(*
Cover

Result: FAIL

$Log: cover8.sml,v $
Revision 1.2  1996/04/01 11:53:39  matthew
updating

 * Revision 1.1  1993/06/23  11:29:05  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)
Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

signature Empty = sig end 
      and  Real = sig type t end ;

structure A = struct type t = real end ;

functor FUN() = A ;

structure B:Empty = A

structure A = struct end ;

signature T = sig structure C:Real sharing C=B end;

functor FUN() = struct end;

signature T' = sig structure C:Real sharing C=B end;
