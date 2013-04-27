/*  ==== LIB-ML FOREIGN INTERFACE ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  This header file identifies how C programmers will be able to access
 *  ML from C.
 *
 *  This is much simpler to implement then the FI interface for
 *  calling from ML into C since ML doesn't naturally deal with data
 *  in the same low-level way that C does.  On the other hand, C
 *  naturally expresses basic concepts from ML, making a workable
 *  interface easier to implement.
 *
 *  The accompanying libml.c then implements the protocol defined here.
 *
 *  Note that system specific versions of the libML.h that users will see
 *  can be extracted automagiclly from this file. 
 *
 *  Revision Log
 *  ------------
 *  $Log: libml.h,v $
 *  Revision 1.3  1995/07/06 15:52:40  brianm
 *  Modifications due to impl. of libml.c
 *
 * Revision 1.2  1995/07/05  22:02:23  brianm
 * Interim version for impl. of libml.c
 *
 * Revision 1.1  1995/07/05  14:55:58  brianm
 * new unit
 * New file.
 *
 *
 */

#ifndef libml_h
#define libml_h

#include "values.h"
#include "sys_types.h"
#include <stddef.h>

extern void libml_init(void);


/* === START LIBML HEADER !!! DO NOT CHANGE THIS LINE !!! ===
 *
 * What follows below is the libML.h header file that users will see and use.
 *
 * Note that the user header file must eliminate the following symbols:
 *
 *   uint32
 *   MLTRUE, MLFALSE, MLUNIT
 *   VERSION
 *
 * The version string VERSION is to allow us to provide confirmation
 * info to the user such as what platform and release version this is
 * provided for and so on.
 *
 *
 */

/* libML.h
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * This header file describes the MLWorks interface for accessing ML from
 * C via the MLWorks Foreign Interface.
 *
 * Version VERSION
 *
 */


typedef uint32 MLvalue;


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

#define   ml_true    MLTRUE
#define   ml_false   MLFALSE

#define   ml_unit    MLUNIT

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

/* === END LIBML HEADER !!! DO NOT CHANGE THIS LINE !!! === */

#endif
