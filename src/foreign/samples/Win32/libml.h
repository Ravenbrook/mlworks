/* libml.h
 *
 * Copyright (C) 1996 Harlequin Ltd.
 *
 * This header file describes the MLWorks interface for accessing ML from
 * C via the MLWorks Foreign Interface.
 *
 * Version (beta)
 *
 */


typedef unsigned int MLvalue;


/* === ML EXTERNAL VALUE INTERFACE === */

extern MLvalue lookup_ml_value (char *name);
  /* Looks up ML values already registered from ML as external */

extern MLvalue call_ml_function (MLvalue fn_handle, int arity, ...);
  /* Calls ML function with given arguments */


/* === DATA CONVERSION FUNCTIONS : ML values --> C objects === */

extern int       ml2c_int(MLvalue val);
extern unsigned  ml2c_word(MLvalue val);
extern double    ml2c_real(MLvalue val);

   /* The following block of functions expect the user to have supplied
    * storage into which the result is written.
    */
extern void      ml2c_string(MLvalue val, char *result);
extern void      ml2c_tuple(MLvalue val, MLvalue *result);
extern void      ml2c_array(MLvalue val, MLvalue *result);

extern int       ml2c_string_length(MLvalue val);
extern int       ml2c_tuple_length(MLvalue val);
extern int       ml2c_array_length(MLvalue val);


/* === DATA CONVERSION FUNCTIONS : C objects --> ML values === */

#define   ml_true    5
#define   ml_false   0

#define   ml_unit    0

extern MLvalue  c2ml_int(int obj);
extern MLvalue  c2ml_word(unsigned obj);
extern MLvalue  c2ml_real(double obj);
extern MLvalue  c2ml_string(char *obj);

extern MLvalue  c2ml_ref(MLvalue val);

extern MLvalue  c2ml_tuple(int count, ...);
extern MLvalue  c2ml_tuple1(int count, MLvalue table[]);

extern MLvalue  c2ml_array(int count, ...);
extern MLvalue  c2ml_array1(int count, MLvalue table[]);


/* === ML REF and ARRAY OPERATIONS === */

extern MLvalue  c2ml_content(MLvalue ref);
extern MLvalue  c2ml_assign(MLvalue ref, MLvalue val);

extern MLvalue  c2ml_sub(MLvalue arr, int index);
extern MLvalue  c2ml_update(MLvalue arr, int index, MLvalue val);


/* === PRIMITIVE DATA CLASSIFICATION === */

enum MLkind { Invalid_MLK, Int_MLK,       String_MLK,  Tuple_MLK,
              Array_MLK,   ByteArray_MLK, Closure_MLK, Other_MLK };

extern enum MLkind ml_kind(MLvalue val);


/* === INTEGRITY MAINTENANCE FUNCTIONS === */

extern void free_ml_value(MLvalue val);
extern void free_ml_vector(int count, MLvalue vec[]);
extern void free_all_ml_values(void);
