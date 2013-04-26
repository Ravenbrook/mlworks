(* ++++ Hello example ML FI interface code ++++ *)
(* ++++ ================================== ++++ *)

(* Opening the ML FI structures *)

use "open";

(* Loading a fStructure *)

   val hello_cset = loadObjectFile("/u/io/ml/3/MLW/src/foreign/hello.so",IMMEDIATE_LOAD);


(* Building a store *)

    val hello_store =
         store{ alloc    = ALIGNED_4,
                 overflow = BREAK,
                 size     = 60,
                 status   = RDWR_STATUS   };



(* Creating objects *)

   val void_object =
         object { ctype     = VOID_TYPE,
               store    = hello_store };

   val str_object =
         object { ctype     = STRING_TYPE{ length = 20 },
               store    = hello_store };

   val int_object1 =
         object { ctype     = INT_TYPE,
               store    = hello_store };

   val int_object2 =
         object { ctype     = INT_TYPE,
               store    = hello_store };

   val ptr_object =
         object { ctype     = ptrType(VOID_TYPE),
               store    = hello_store };



(* Initialising object values - these will be our arguments *)

   setString(str_object, "ML Forever!");
   setInt(int_object1, 23);



(* Examining object values *)

   getString(str_object);
   getInt(int_object1);


(* Defining a c_signature object *)

   val hello_cinfo = newSignature();


(* Adding a new fSignature entry *)

   defEntry(hello_cinfo,
             FUN_DECL { name = "hello",
                       source = ([ptrType(CHAR_TYPE), INT_TYPE] : c_type list),
                       target = (INT_TYPE) }
            );


(* Make a `callable object' lookup function for our foreign code *)

   val def_hello = defineForeignFun(hello_cset,hello_cinfo);


(* Extract a foreign function object as an ML value *) 

   val hello = def_hello "hello";;


(* Setting up string pointers ... *)

   setPtrType { ptr = ptr_object, data = str_object };
   setPtrAddrOf { ptr = ptr_object, data = str_object };
   castPtrType { ptr = ptr_object, ctype = CHAR_TYPE };


(* Call the foreign function *)

   call hello ([ptr_object,int_object1], int_object2);


(* Extracting the result data *)

   getInt(int_object2);
