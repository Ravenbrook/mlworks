(*
Debug info must be cleared when recompilation
takes place and the debug switches are off.

Result: OK
 
$Log: debug.sml,v $
Revision 1.6  1998/02/06 15:00:46  jont
[Bug #70055]
Modify to use argument in function being traced

 * Revision 1.5  1996/03/27  11:50:57  stephenb
 * Turn on debugging so the breakpoint command actually runs!
 *
 * Revision 1.4  1996/03/26  16:06:45  stephenb
 * Replace the out of date call to MLWorks.Debugger.break with
 * a call to Shell.Trace.breakpoint.
 *
 * Revision 1.3  1996/03/26  14:02:12  jont
 * Fix out of date Shell calls
 *
 * Revision 1.2  1996/02/23  16:28:48  daveb
 * Converted Shell structure to new capitalisation convention.
 *
 * Revision 1.1  1994/06/21  10:57:10  jont
 * new file
 *
 * Copyright (c) 1994 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compiler.generateTraceProfileCode, true);
Shell.Options.set(Shell.Options.Compiler.generateVariableDebugInfo,true);
functor F(type t val args:t list val compute:t list -> t) =
  struct
    fun f args =
      let
        val result = compute args
      in
        ()
      end
    val args = args
  end;
structure F1 = F(struct 
                   type t = int
                   val args = [1,2]
                   fun compute args = 
                     let
                       fun compute [] result = result
                         | compute (arg::args) result = compute args (result+arg)
                     in
                       compute args 0
                     end
                            end);
structure F2 = F(struct
                   type t = string
                   val args = ["1","2"]
                   fun compute args = 
                     let
                       fun compute [] result = result
                         | compute (arg::args) result = compute args (result^arg)
                     in
                       compute args ""
                     end
                  end);
Shell.Trace.breakpoint "f";
Shell.Options.set(Shell.Options.Compiler.generateVariableDebugInfo,false);
functor F(type t 
          val args:t list 
          val compute:t list -> t) =
  struct
    fun f args =
      let
        val result = compute args
      in
        ()
      end
    val args = args
  end;

structure F1 = F(struct 
                   type t = int
                   val args = [1,2]
                   fun compute args = 
                     let
                       fun compute [] result = result
                         | compute (arg::args) result = compute args (result+arg)
                     in
                       compute args 0
                     end
                  end);

structure F2 = F(struct
                   type t = string
                   val args = ["1","2"]
                   fun compute args = 
                     let
                       fun compute [] result = result
                         | compute (arg::args) result = compute args (result^arg)
                     in
                       compute args ""
                     end
                  end);
(F1.f F1.args,F2.f F2.args);
