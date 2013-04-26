(* *)

use "open";

(* Get Threads Library *)
local
   open MLWorks.Threads;
   open Internal;
   open Preemption;

   val _ = set_interval(10);
   val _ = start();

in
   val fork = fork;
   val yield_to = fn thd => yield_to(get_id thd);
end;

   (*  Loading X libraries *)

   val libX11 = loadObjectFile("/usr/lib/libX11.so.5.0",IMMEDIATE_LOAD);
   val libXt  = loadObjectFile("/usr/lib/libXt.so.5.0",IMMEDIATE_LOAD);
   val libXm  = loadObjectFile("/usr/lib/libXm.so.1.2",IMMEDIATE_LOAD);

   (*  TEST 2.1 - Building X stores *)


   val x_store =
         store{ alloc    = SUCC,
                 overflow = EXTEND,
                 size     = 1000,
                 status   = RDWR_STATUS   };


   val x_name = "foreign/xtst1.so";

  
   val x_struct = loadObjectFile(x_name,IMMEDIATE_LOAD);


   symbols(x_struct);
   symbolInfo(x_struct,"demo_box");



   (* TEST 2.2 - Building X OBJECT's *)

   val x_object =
         object { ctype     = STRING_TYPE{ length = 64 },
               store    = x_store };
   
   val x_object1 = dupObject x_object;


   val void_object =
         object { ctype     = VOID_TYPE,
               store    = x_store };


   (* TEST 2.3 - Building X signatures *)

   val x_sig = newSignature();


   defEntry(x_sig,
             FUN_DECL 
               { name = "init_app",
                 source = [VOID_TYPE],
                 target = VOID_TYPE });
   
   val init_app = defineForeignFun(x_struct,x_sig)("init_app");

   defEntry(x_sig,
             FUN_DECL 
               { name = "demo_box",
                 source = [STRING_TYPE{ length = 64 }],
                 target = VOID_TYPE });
   
   val demo_box = defineForeignFun(x_struct,x_sig)("demo_box");

   val thd1 = fork(fn () => call(init_app)([void_object],void_object))();

   setString(x_object1,"Hope Springs Eternal"); 

   val thd2 = fork(fn () => call(demo_box)([x_object1],void_object))();
