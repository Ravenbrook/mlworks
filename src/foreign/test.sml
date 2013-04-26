(* test script for foreign interface *)



(* *)

use "open";



   (* TEST 1 - C Interface *)

    val my_store =
         store{ alloc    = SUCC,
                 overflow = EXTEND,
                 size     = 1000,
                 status   = RDWR_STATUS   };

    val my_store_a4 =
         store{ alloc    = ALIGNED_4,
                 overflow = BREAK,
                 size     = 80,
                 status   = RDWR_STATUS   };

   (*  TEST 1.1 - Building C structures *)

   val f_name = "foreign/tst.so";
  
   val my_struct = loadObjectFile(f_name,IMMEDIATE_LOAD);

   filesLoaded();
   fileInfo my_struct;
   symbols my_struct;
   symbolInfo(my_struct,"hw");



   (* TEST 1.2 - Building C OBJECT's *)

   val my_object =
         object { ctype     = VOID_TYPE,
               store    = my_store };
   
   val my_object1 = dupObject(my_object);

   val int_object1 =
         object { ctype     = INT_TYPE,
               store    = my_store };

   setInt(int_object1, 3);
   
   val int_object2 =
         object { ctype     = INT_TYPE,
               store    = my_store };

   setInt(int_object2, 5);
   getInt(int_object1);
   getInt(int_object2);

   val my_sig = newSignature();


(* *)


   (* TEST 1.3 - Building C Signatures *)

   defEntry(my_sig, FUN_DECL { name = "hw",
                               source = [] : c_type list,
                               target = VOID_TYPE });
   
  
   defEntry(my_sig, VAR_DECL { name  = "my_value",
	 		      ctype = INT_TYPE});
   
   showEntries(my_sig);
   
   val lookup_my_sig =  lookupEntry my_sig;


   (* TEST 1.4 - Extracting C function objects & calling them *)

   val hw = defineForeignFun(my_struct,my_sig)("hw");

   call(hw)([],my_object);


   (* TEST 1.5 - Returning a result *)

   defEntry(my_sig, FUN_DECL { name = "hw1",
			      source = [] : c_type list,
			      target = INT_TYPE});
   
   showEntries my_sig;

   val hw1 = defineForeignFun(my_struct,my_sig)("hw1");

   call(hw1)([],int_object1);

   getInt(int_object1);


   (* TEST 1.6 - Argument passing and returning results *)

   defEntry(my_sig, FUN_DECL { name = "hw2",
                               source = [INT_TYPE] : c_type list,
                               target = INT_TYPE });
   
   showEntries(my_sig);

   val hw2 = defineForeignFun(my_struct,my_sig)("hw2");

   setInt(int_object1,4);

   call(hw2)([int_object1],int_object2);

   getInt(int_object2);


   (* TEST 1.7 - Argument passing and returning results *)

   defEntry(my_sig, FUN_DECL { name = "hw2",
                               source = [INT_TYPE] : c_type list,
                               target = INT_TYPE });
   
   showEntries(my_sig);

   val hw2 = defineForeignFun(my_struct,my_sig)("hw2");

   setInt(int_object1,4);

   call(hw2)([int_object1],int_object2);

   getInt(int_object2);


   (* TEST 1.8 - Creating C-string object's *)

   val str_object1 =
         object { ctype     = STRING_TYPE{ length = 64 },
               store    = my_store };

   setString(str_object1,"Hello World");
   getString(str_object1);
   
   val str_object1_1 = dupObject(str_object1);
   castObjectType(str_object1_1, ARRAY_TYPE{ ctype = CHAR_TYPE, length = 64, size = NONE });

   val char_object1 =
         object { ctype     = CHAR_TYPE,
               store    = my_store };

   indexObject{array=str_object1_1,tgt=char_object1,index=0};
   getChar(char_object1);

   indexObject{array=str_object1_1,tgt=char_object1,index=1};
   getChar(char_object1);

   val str_object2 =
         object { ctype     = STRING_TYPE{ length = 64 },
               store    = my_store };

   setString(str_object2,"");
	 

   (* TEST 1.9 - Argument passing and returning results *)

   defEntry(my_sig, FUN_DECL { name = "hw3",
                               source = [INT_TYPE] : c_type list,
                               target = STRING_TYPE{ length = 64 } });
   
   showEntries(my_sig);

   val hw3 = defineForeignFun(my_struct,my_sig)("hw3");

   setInt(int_object1,24);

   call(hw3)([int_object1],str_object2);

   getString(str_object2);



   (* TEST 1.10 - loading other code ... *)
 

   val libc = loadObjectFile("/lib/libc.so.1",IMMEDIATE_LOAD)
              handle _ => loadObjectFile("/usr/lib/libc.so",IMMEDIATE_LOAD)
              handle _ => loadObjectFile("/usr/lib/libc.so.1.8",IMMEDIATE_LOAD)
              handle _ => loadObjectFile("/usr/lib/libc.so.1.8.1",IMMEDIATE_LOAD);
       
   symbols(libc);

   val libxm = loadObjectFile("/usr/lib/libXm.so.2.12",IMMEDIATE_LOAD)
               handle _ => loadObjectFile("/usr/lib/libXm.so.2.11",IMMEDIATE_LOAD)
               handle _ => loadObjectFile("/usr/lib/libXm.so.1.2",IMMEDIATE_LOAD);

   symbols(libxm);


   (* TEST 1.11 - Argument passing and returning results *)

   defEntry(my_sig, FUN_DECL { name = "hw4",
                               source = [STRING_TYPE{ length = 64 }],
                               target = INT_TYPE
                             }
            );
   
   showEntries(my_sig);

   val hw4 = defineForeignFun(my_struct,my_sig)("hw4");

   setString(str_object1,"Hope springs Eternal"); 

   call(hw4)([str_object1],int_object1);

   getInt(int_object1);


   (* TEST 1.12 - Structures and foreign data maniputlation *)


   val Tnorm = normaliseType my_sig

   val my_type =
       Tnorm  (structType("my_type",
                          [  ("num",  INT_TYPE),
                             ("ch",   CHAR_TYPE),
                             ("iptr", ptrType(INT_TYPE))
                          ]
		         ));

   defEntry(my_sig, TYPE_DECL { name = "my_type",
                               defn = my_type,
                               size = sizeOf(my_type) }
	    );

   val void_object_a4_1 = object { ctype = VOID_TYPE, store = my_store_a4 };

   val struct_object_a4_1 =
         object { ctype    = my_type,
                  store    = my_store_a4 };

   val ch_object_a4_1 =
         object { ctype    = CHAR_TYPE,
                  store    = my_store_a4 };

   val int_object_a4_1 =
         object { ctype     = INT_TYPE,
                  store    = my_store_a4 };

   val int_object_a4_2 =
     object { ctype     = INT_TYPE,
	      store    = my_store_a4 };


   val tmp_object_a4_1 = tmpObject void_object_a4_1;

   dispObject void_object_a4_1;
   dispObject struct_object_a4_1;
     
   selectObject{ record=struct_object_a4_1, field="num",  tgt=tmp_object_a4_1};
   setInt(tmp_object_a4_1,45);

   dispObject tmp_object_a4_1;

   selectObject{ record=struct_object_a4_1, field="ch",   tgt=tmp_object_a4_1};
   setChar(tmp_object_a4_1,81);

   dispObject tmp_object_a4_1;

   selectObject{ record=struct_object_a4_1, field="iptr", tgt=tmp_object_a4_1};

   dispObject tmp_object_a4_1;

   setPtrAddrOf{ ptr=tmp_object_a4_1, data=int_object_a4_1 };

   dispObject tmp_object_a4_1;

   setInt(int_object_a4_1,2020);

   dispObject tmp_object_a4_1;

   setPtrType{ ptr=tmp_object_a4_1, data=struct_object_a4_1};
   setPtrAddrOf{ ptr=tmp_object_a4_1, data=struct_object_a4_1};

   dispObject tmp_object_a4_1;

   dispObject struct_object_a4_1;

   defEntry(my_sig, FUN_DECL { name = "hw5",
                               source = [ptrType(my_type)],
                               target = INT_TYPE
                             }
            );
   
   showEntries(my_sig);

   val hw5 = defineForeignFun(my_struct,my_sig)("hw5");

   call(hw5)([tmp_object_a4_1],int_object_a4_2);

   getInt(int_object_a4_2);


   (* TEST 1.13 - Structures and foreign data maniputlation *)

   
   defEntry(my_sig, FUN_DECL { name = "hw6",
                               source = [],
                               target = UNSIGNED_INT_TYPE
                             }
            );
   
   showEntries(my_sig);

   val uint_object_a4_1 = object{ ctype = UNSIGNED_INT_TYPE, store = my_store_a4 };

   val hw6 = defineForeignFun(my_struct,my_sig)("hw6");

   call(hw6)([],uint_object_a4_1);

   getWord32(uint_object_a4_1);

   setObjectMode(int_object_a4_1,REMOTE_OBJECT);
   
   setAddr{obj=int_object_a4_1,addr=uint_object_a4_1};

   getInt(int_object_a4_1);


   (*  Loading X libraries *)

   val libX11 = loadObjectFile("/usr/lib/libX11.so.5.0",IMMEDIATE_LOAD);
   val libXt  = loadObjectFile("/usr/lib/libXt.so.5.0",IMMEDIATE_LOAD);
   val libXm  = loadObjectFile("/usr/lib/libXm.so",IMMEDIATE_LOAD);


   (*  TEST 2.1 - Building C structures *)

   val x_store =
          store{ alloc    = SUCC,
                 overflow = EXTEND,
                 size     = 1000,
                 status   = RDWR_STATUS   };

   val x_name = "foreign/xtst.so";
  
   val x_struct = loadObjectFile(x_name,IMMEDIATE_LOAD);

   symbols(x_struct);
   symbolInfo(x_struct,"demo_box");


   (* TEST 2.2 - Building C OBJECT's *)

   val x_object =
         object { ctype     = STRING_TYPE{ length = 64 },
               store    = x_store };
   
   val x_object1 = dupObject(x_object);


   val void_object =
         object { ctype     = VOID_TYPE,
                  store     = x_store };


   (* TEST 2.3 - Building C Signatures *)

   val x_sig = newSignature();

   defEntry(x_sig,
             FUN_DECL 
               { name = "demo_box",
                 source = [STRING_TYPE{ length = 64 }],
                 target = VOID_TYPE });
   
   val demo_box = defineForeignFun(x_struct,x_sig)("demo_box");

   setString(x_object1,"Hope springs Eternal"); 

   call(demo_box)([x_object1],void_object);



   (* Test of pointer equality functions *)

     setString (str_object1, "Hi There!");
     setString (str_object2, "FooBar");
     
     val str_ptr1 =
         object { ctype     = ptrType (STRING_TYPE {length=30}), 
                  store     = my_store };

     val str_ptr2 =
         object { ctype     = ptrType (STRING_TYPE {length=30}),
                  store     = my_store };
     
     (true = isEqPtr (str_ptr1, str_ptr2));

     setPtrAddrOf {ptr=str_ptr2, data=str_object2};
     
     (false = isEqPtr (str_ptr1, str_ptr2));

     getString (str_object1);
     getString (str_object2);

     objectType (str_ptr1);
     objectType (str_ptr2);
     
     (true =  (isNullPtr str_ptr1));
     (false = (isNullPtr str_ptr2));

     fun string_to_char_ptr {string=str, ptr=char_ptr} =
         case objectType (str) of
            STRING_TYPE (_) =>
              ( setPtrAddrOf { ptr=char_ptr, data=str } ;
                castPtrType   { ptr=char_ptr, ctype=CHAR_TYPE }
              )
         |  _ => raise ForeignType

     fun char_ptr_to_string {ptr=char_ptr, string=str} =
         let val str_type =  objectType (str)
         in
	     case str_type of
                STRING_TYPE (_) =>
                  ( castPtrType { ptr=char_ptr, ctype=str_type } ;
   	            derefObject  { ptr=char_ptr, tgt=str }
                  )
             |  _ => raise ForeignType
         end;
	 

   objectType (str_ptr1);

   string_to_char_ptr { string=str_object1, ptr=str_ptr1};

   objectType (str_ptr1);

   getString (str_object1);

   char_ptr_to_string { string=str_object2, ptr=str_ptr1 };

   getString (str_object2);
   
(* DEPRECATED TESTS:

   (* TEST 0 - Basic Core *)

   open ForeignCore_;


   (*
   val fpath = "foreign/tst.so";
   val fpath = "foreign/nickb.so";
   *)

   val fpath = "foreign/tst.so";

   val fobj = load_object (fpath,LOAD_LATER);

   val obj_lst = list_content fobj;

   val hw = find_value (fobj, "hw");

   val my_value = find_value (fobj, "my_value");

   call_unit_fun hw;
*)
	 
