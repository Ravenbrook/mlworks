/*  ==== LIB-ML C INTERFACE ====
 *
 *  Copyright (C) 1995 Harelquin Ltd.
 *
 *  Implementation
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: libml.c,v $
 *  Revision 1.7  1998/02/23 18:16:31  jont
 *  [Bug #70018]
 *  Modify declare_root to accept a second parameter
 *  indicating whether the root is live for image save
 *
 * Revision 1.6  1996/08/23  16:06:32  brianm
 * [Bug #1564]
 * Minor corrections (Bugs 1564 & 1565).
 *
 * Revision 1.5  1996/06/04  16:01:57  brianm
 * Minor correction: GLOBAL_TRANSIENT -> GLOBAL_DEFAULT
 *
 * Revision 1.3  1996/02/14  14:57:17  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.2  1995/07/07  00:36:52  brianm
 * Further implementation.
 *
 * Revision 1.1  1995/07/06  14:21:41  brianm
 * new unit
 * New file.
 *
 *
 */

#include "alloc.h"
#include "allocator.h"
#include "gc.h"
#include "tags.h"
#include "environment.h"
#include "values.h"
#include "interface.h"
#include "sys_types.h"
#include "global.h"

#include <string.h>
#include <stddef.h>
#include <stdarg.h>

#include "libml.h"

/* === Internal Utilities === */ 

#define return_MLvalue(x)       return(TO_MLvalue(x))
#define return_MLunit           return((MLvalue)MLUNIT)

#define ISINT(x)                (((x) & 0x3) == 0)
#define MKPTR(x)                ((unsigned)(x) + 1)
#define UNPTR(x)                ((mlval *)((x) - 1))
#define MLVAL(x)                (*UNPTR(x))

/* === Root Table Segments ===
 *
 * 
 * A dynamic map of root mlval's known externally to ML needs to be
 * maintained.  This map consists of a singly-linked list of segments,
 * each of which contains an array of mlval's.  Vacant entries in this
 * array are marked as FREE and such entries can be reused.
 * 
 * Each segment consists of:
 * 
 *   - an array of mlvals of size ROOT_TABLE_SIZE
 * 
 *   - an integer, top, giving a quickly accessed free element.  After a time,
 *     this cannot be used and the array has to be searched linearly for any
 *     FREE elements.
 * 
 *   - an integer, vacant, giving a count of the FREE elements available.  This has 
 *     to be maintained when getting and freeing elements. It can be used to avoid
 *     scanning those segments with no FREE entries.
 *
 *     A segment array will only be scanned for FREE elements when
 *     the vacant field is non-zero.  New segments are added only
 *     if all segments are occupied.
 * 
 *   - A forwards link to the next segment (if it exists).  New segments are
 *     added at the head of the list (not the end), ensuring that there is
 *     a supply of FREE elements nearer the start of the search, rather than the end.
 *
 * Note that ML integers don't need to be `boxed' in this way - by
 * using the fact that ML allocates double-aligned, we know that
 * pointers generated this way will be even (actually divisible by
 * no. of bytes per word) and so adding one makes them odd.
 * 
 * This property means that ML integers can be treated as MLvalues as
 * they stand.
 * 
 */

#define FREE                    MLERROR
#define ROOT_TABLE_SIZE         20

struct segment{
   mlval table[ROOT_TABLE_SIZE];
   int top, vacant;
   struct segment *next_seg;
};

typedef struct segment segment;


static int inside_table(mlval *root, mlval *ptr)
{
   int diff;

   diff = ((ptrdiff_t)((unsigned)ptr - (unsigned)root))/sizeof(mlval);

   return( (0 <= diff) && (diff < ROOT_TABLE_SIZE) );
}
 
static segment *root_table = NULL;

static segment *new_segment(void)
{
  segment *rt;
  mlval *table;
  int i;

  rt = (segment *)malloc(sizeof(segment));
  (rt -> top)      = ROOT_TABLE_SIZE - 1;
  (rt -> vacant)   = ROOT_TABLE_SIZE;
  (rt -> next_seg) = root_table;

  table = (rt -> table);
  for (i=0; i < ROOT_TABLE_SIZE; i++) table[i] = FREE;

  root_table = rt;  /* Update root_table */

  return(rt);
}


static mlval *scan_for_box(segment *current)
{ int     top, i;
  mlval   *table, *box;

  for(;;){

     if (current -> vacant > 0){
	top   = current -> top;
	table = current -> table;

	if (top >= 0)
	  { if (table[top] == FREE) {
	       box = &table[top];
	       current -> top--;
	       current -> vacant--;
	       return(box);
	      }
	    else current -> top = -1;
	  };

	/* Now scan table (upwards) for free elements ... */

	for (i=0; i < ROOT_TABLE_SIZE; i++){
	   if (table[i] == FREE)
             { current -> vacant--;
               return(&table[i]);
             };
	};
     };

     /* There's no free elements in this segment ... so try next one */
     /* But first check if you have reached the end ... */

     if (current -> next_seg == NULL)
       { /* Add fresh segment to the root table and set
          * current segment also.  Doing this will create
          * something to be found.
          */

	 current = new_segment();
       }
     else { current = current -> next_seg; };
  };

  return(NULL); /* NOT REACHED */
}

static mlval *next_box(void)
{ 
  if (root_table == NULL)
    { /* Initialise empty root_table */

      root_table = new_segment();
    };

  return( scan_for_box(root_table) );
}

static void release_box(mlval *box)
{ segment *current;

  if (box == NULL) return;
  if (root_table == NULL) return;

  current = root_table;
  for (;;){
    if (inside_table(current -> table,box))
      { current -> vacant--;  
	break;
      };
    if (current -> next_seg == NULL) return;
       /* If the above is true then pointer isn't one of ours */
    current = current -> next_seg;
  };

  retract_root(box);
  *box = FREE;
}

static void release_all()
{ segment *current;
  mlval *table;
  int vacant, top, i;

  current = root_table;

  for(;;){
    if (current == NULL) return;

    vacant = current -> vacant;

    if (vacant < ROOT_TABLE_SIZE)
      { top = current -> top;
        table = current -> table;
        for (i=top + 1; i<ROOT_TABLE_SIZE; i++)
           if (table[i] != FREE)
             { retract_root(&table[i]);
               table[i] = FREE;
             };
      };

    current -> vacant = ROOT_TABLE_SIZE;
    current -> top    = ROOT_TABLE_SIZE - 1;

    current = current -> next_seg;
  };
}    



static MLvalue TO_MLvalue(mlval v)
{
  mlval *box;

  if (ISINT(v)) return((MLvalue)v);

  box = next_box();
  *box = v;
  declare_root(box, 0);

  return((MLvalue)MKPTR(box));
}

static mlval TO_mlval(MLvalue v)
{  return( (mlval)(ISINT(v) ? v : MLVAL(v)) ); }


/* === ML EXTERNAL VALUE INTERFACE === */

static mlval external_ml_values = MLNIL;

static mlval add_external_ml_value(mlval arg)
{ char *str, *name;
  mlval item = MLUNIT;
  mlval current = external_ml_values;

  name = CSTRING(FIELD(arg,0));

  declare_root(&item, 0);
  declare_root(&current, 0);

  for(;;){
    if (MLISNIL(current)) break;
    
    item = MLHEAD(current);
    str  = CSTRING(FIELD(item,0));

    if (strcmp(name,str) == 0)
      { FIELD(item,1) = FIELD(arg,1);  /* Updates existing record */
        break;
      };

    item = MLUNIT;
    current = MLTAIL(current);
  };

  if (item == MLUNIT)
    { external_ml_values = cons(arg,external_ml_values); };

  retract_root(&item);
  retract_root(&current);

  return(MLUNIT);
}


static mlval delete_external_ml_value(mlval arg)
{ char *str, *name;
  mlval item = MLUNIT;
  mlval prefix = MLNIL;
  mlval current = external_ml_values;

  name = CSTRING(arg);

  declare_root(&item, 0);
  declare_root(&prefix, 0);
  declare_root(&current, 0);

  for(;;){
    if (MLISNIL(current)) break;
    
    item = MLHEAD(current);
    str = CSTRING(FIELD(item,0));

    if (strcmp(name,str) == 0)
      { break; }
    else
      { prefix = cons(item,prefix); };

    item = MLUNIT;
    current = MLTAIL(current);
  };

  if (item != MLUNIT)
    {  /* item != MLUNIT means `item found' */ 
       for(;;){
         if (MLISNIL(prefix)) break;

         item = MLHEAD(prefix);
         current = cons(item,current);
         prefix = MLTAIL(prefix);
       };

       external_ml_values = current;
    };

  retract_root(&item);
  retract_root(&prefix);
  retract_root(&current);

  return(MLUNIT);
}

static mlval external_ml_value_names(mlval arg)
{ mlval item = MLUNIT;
  mlval names = MLNIL;
  mlval current = external_ml_values;

  declare_root(&item, 0);
  declare_root(&names, 0);
  declare_root(&current, 0);

  for(;;){
    if (MLISNIL(current)) break;

    item = MLHEAD(current);
    names = cons(FIELD(item,0),names);

    current = MLTAIL(current);
  };

  retract_root(&item);
  retract_root(&names);
  retract_root(&current);

  return(names);
}

static mlval clear_external_ml_values(mlval arg)
{
  external_ml_values = MLNIL;
  return(MLUNIT);
}


extern void libml_init(void)
{
  declare_global("external ml values",&external_ml_values,
                 GLOBAL_DEFAULT,NULL,NULL,NULL);

  env_function("add external ml value", add_external_ml_value);
  env_function("delete external ml value", delete_external_ml_value);
  env_function("external ml value names", external_ml_value_names);
  env_function("clear external ml values", clear_external_ml_values);
}


extern MLvalue lookup_ml_value (char *name)
{ mlval current, item;
  char *str;

  current = external_ml_values;

  for(;;){
    if (MLISNIL(current)) return((MLvalue)NULL);
    
    item = MLHEAD(current);
    str = CSTRING(FIELD(item,0));

    if (strcmp(name,str) == 0) return(FIELD(item,1));

    current = MLTAIL(current);
  };

  return((MLvalue)NULL);   /* NOT REACHED */
}


extern MLvalue call_ml_function (MLvalue fn_handle, int arity, ...)
{ mlval tup; 
  va_list ap;
  int i;

  tup = allocate_record((size_t)arity);

  va_start(ap,arity);

  for (i=0; i < arity; i++)
    FIELD(tup,i) = TO_mlval(va_arg(ap,MLvalue));

  va_end(ap);

  return_MLvalue(callml(tup,fn_handle));
}



/* === DATA CONVERSION FUNCTIONS : ML values --> C objects === */

extern int       ml2c_int(MLvalue val)
{ return( CINT(TO_mlval(val)) ); }

extern unsigned  ml2c_word(MLvalue val)
{ unsigned *content;
  content = (unsigned *)CBYTEARRAY(TO_mlval(val));
  return( *content );
}

extern double    ml2c_real(MLvalue val)
{ return( GETREAL(TO_mlval(val)) ); }

extern void      ml2c_string(MLvalue val, char *result)
{ int len;
  mlval str;

  str = TO_mlval(val);
  len = CSTRINGLENGTH(str);

  strncpy(result,CSTRING(str),(size_t)len);
}


extern int       ml2c_string_length(MLvalue val)
{ return( CSTRINGLENGTH(TO_mlval(val)) ); }

extern void      ml2c_tuple(MLvalue val, MLvalue *result)
{ int i, len;
  mlval tup;

  tup = TO_mlval(val);
  len = NFIELDS(tup);

  for (i=0; i < len; i++){
     result[i] = TO_MLvalue(FIELD(tup,i));
  };
}


extern int       ml2c_tuple_length(MLvalue val)
{ return( NFIELDS(TO_mlval(val)) ); }

extern void      ml2c_array(MLvalue val, MLvalue *result)
{ int i, len;
  mlval arr;

  arr = TO_mlval(val);
  len = LENGTH(ARRAYHEADER(arr));

  for (i=0; i < len; i++){
     result[i] = TO_MLvalue(MLSUB(arr,i));
   };
}

extern int       ml2c_array_length(MLvalue val)
{ return( LENGTH(ARRAYHEADER(TO_mlval(val))) ); }


/* === DATA CONVERSION FUNCTIONS : C objects --> ML values === */

#define   ml_true    MLTRUE
#define   ml_false   MLFALSE

#define   ml_unit    MLUNIT

extern MLvalue  c2ml_int(int obj)
{ return_MLvalue( MLINT( obj ) ); }

extern MLvalue  c2ml_word(unsigned obj)
{ mlval val;
  unsigned *item;

  val = allocate_word32();

  item = (unsigned *)CBYTEARRAY(val);
  *item = obj;

  return_MLvalue(val);
}

extern MLvalue  c2ml_real(double obj)
{ mlval val;

  val = allocate_real();

  SETREAL(val,obj);

  return_MLvalue(val);
}
  

extern MLvalue  c2ml_string(char *obj)
{ return_MLvalue( ml_string( (const char *)obj ) ); }

extern MLvalue  c2ml_ref(MLvalue val)
{ return_MLvalue( ref( TO_mlval(val) ) ); }

extern MLvalue  c2ml_tuple(int count, ...)
{ mlval tup; 
  va_list ap;
  int i;

  tup = allocate_record((size_t)count);

  va_start(ap,count);

  for (i=0; i < count; i++)
    FIELD(tup,i) = TO_mlval(va_arg(ap,MLvalue));

  va_end(ap);

  return_MLvalue(tup);
}

extern MLvalue  c2ml_tuple1(int count, MLvalue table[])
{ mlval tup; 
  int i;

  tup = allocate_record((size_t)count);

  for (i=0; i < count; i++)
    FIELD(tup,i) = TO_mlval(table[i]);

  return_MLvalue(tup);
}

extern MLvalue  c2ml_array(int count, ...)
{ mlval arr; 
  va_list ap;
  int i;

  arr = allocate_array((size_t)count);

  va_start(ap,count);

  for (i=0; i < count; i++)
    MLUPDATE(arr,i,TO_mlval(va_arg(ap,MLvalue)));

  va_end(ap);

  return_MLvalue(arr);
}

extern MLvalue  c2ml_array1(int count, MLvalue table[])
{ mlval arr; 
  int i;

  arr = allocate_array((size_t)count);

  for (i=0; i < count; i++)
    MLUPDATE(arr,i,TO_mlval(table[i]));

  return_MLvalue(arr);
}



/* === ML REF and ARRAY OPERATIONS === */

extern MLvalue  c2ml_content(MLvalue ref)
{ return_MLvalue( MLDEREF( TO_mlval(ref) ) ); }

extern MLvalue  c2ml_assign(MLvalue ref, MLvalue val)
{ MLUPDATE( TO_mlval(ref), 0, TO_mlval(val) );
  return_MLunit;
}


extern MLvalue  c2ml_sub(MLvalue arr, int index)
{ return_MLvalue( MLSUB( TO_mlval(arr), (mlval)MLINT(index) ) ); }

extern MLvalue  c2ml_update(MLvalue arr, int index, MLvalue val)
{ MLUPDATE( TO_mlval(arr), index, TO_mlval(val) );
  return_MLunit;
}


/* === PRIMITIVE DATA CLASSIFICATION === */

static enum MLkind decode_hdr(unsigned hdr)
{
  switch (SECONDARY(hdr)) {

     case RECORD    :   return( Tuple_MLK      );
     case STRING    :   return( String_MLK     );
     case ARRAY     :   return( Array_MLK      );
     case BYTEARRAY :   return( ByteArray_MLK  );
     case CODE      :   return( Closure_MLK    );

     case BACKPTR   :   /* FALLTHROUGH */
     case WEAKARRAY :   return( Other_MLK      );

     default        :   return( Invalid_MLK    );
  };
}

static enum MLkind prim_ml_kind(mlval val)
/* WARNING:
 *
 * This function is critically dependent upon tags.h.  Changes
 * to that file could seriously affect the operation of this
 * function.
 *
 */
{
   switch (PRIMARY(val)) {

      case HEADER   :   return( decode_hdr((unsigned)val) );

      case POINTER  :   return( decode_hdr(GETHEADER(val)) );

      case INTEGER0 :   /* FALLTHROUGH */
      case INTEGER1 :   return( Int_MLK        );

      case REFPTR   :   /* FALLTHROUGH */
      case PAIRPTR  :   return( Tuple_MLK      );

      default :         return( Invalid_MLK    );
   };
}

extern enum MLkind ml_kind(MLvalue obj)
{ return( prim_ml_kind( TO_mlval(obj) )); }



/* === INTEGRITY MAINTENANCE FUNCTIONS === */

extern void free_ml_value(MLvalue val)
{
  if (ISINT(val)) return;
  release_box(UNPTR(val));
}

extern void free_ml_vector(int count, MLvalue vec[])
{ int i;

  for( i=0; i < count; i++ ) free_ml_value(vec[i]);
}

extern void free_all_ml_values(void)
{ release_all(); };
