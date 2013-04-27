(*  New Jersey emulation of runtime environment
 *
 *  Copyright (C) 1996 Harlequin Ltd
 *
 *  $Log: nj_env.sml,v $
 *  Revision 1.1  1996/01/23 10:41:34  matthew
 *  new unit
 *  Emulation of runtime environment
 *
*)


local
  (* A handful of environment functions that we need *)
  (* We only need the functions that actually get called by the compiler here *)

  (* http://www.standardml.org/Basis/os-process.html#SIG:OS_PROCESS.getEnv:VAL *)
  val environment = OS.Process.getEnv
  
  (* http://www.standardml.org/Basis/os-file-sys.html#SIG:OS_FILE_SYS.chDir:VAL *)
  val setwd = OS.FileSys.chDir

  (* http://www.standardml.org/Basis/os-file-sys.html#SIG:OS_FILE_SYS.getDir:VAL *)
  val getwd = OS.FileSys.getDir

  (* http://www.standardml.org/Basis/os-file-sys.html#SIG:OS_FILE_SYS.realPath:VAL *)
  val realpath = OS.FileSys.realPath

  (* http://www.smlnj.org/doc/SMLofNJ/pages/unsafe.html#SIG:UNSAFE.cast:VAL *)
  type T = int ref
  val tcast : 'a -> T = Unsafe.cast

  val env_refs = ref [] : (string * T) list ref

  fun add_env_function (name,f) =
    env_refs := (name,tcast f) :: !env_refs

  (* These may be all we need *)
  val _ =
    (add_env_function ("system os unix environment",environment);
     add_env_function ("system os unix setwd",setwd);
     add_env_function ("system os unix getwd",getwd);
     add_env_function ("system os unix realpath",realpath))

  exception UnimplementedEnv of string
  fun unimplemented name =
    (TextIO.output (TextIO.stdOut, "unimplemented env function: " ^ name ^ "\n");
     raise UnimplementedEnv name)

in
  fun nj_environment e =
    let
      fun lookup [] = tcast (fn _ => unimplemented ("Environment function " ^ e))
        | lookup ((a,b)::c) =
          if e = a then b else lookup c
    in
      lookup (!env_refs)
    end
end
