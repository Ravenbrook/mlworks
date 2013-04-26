(* ml_ar.sml *)
(*
 *
 * runtime system script maker for ML
 *
 * $Log: ml_ar.sml,v $
 * Revision 1.2  1996/05/16 12:55:29  stephenb
 * Update wrt MLWorks.OS.arguments -> MLWorks.arguments change.
 *
 * Revision 1.1  1993/04/05  12:45:53  jont
 * Initial revision
 *
 * Copyright (c) 1993 Harlequin Ltd.
 *)

require "../utils/__lists";

exception err of string

fun do_file filename =
  let
    val names = MLWorks.Internal.Images.table filename
      handle MLWorks.Internal.Images.Table string => raise err string
  in
    Lists_.iterate
    (fn str => output(std_out, str ^ "\n"))
    names
  end

fun obey[filename] =
  (do_file filename handle err string =>
    output(MLWorks.IO.std_err, "ml_ar: " ^ string ^ "\n"))
  | obey args =
     output(MLWorks.IO.std_err, "ml_ar: bad args: required ml_ar <library name>\n")

fun obey1["-save", filename] =
  (MLWorks.save(filename, fn () => obey(MLWorks.arguments()));
   ())
  | obey1 arg = (output(MLWorks.IO.std_err, "Bad initial args\n");
		 Lists_.iterate (fn str => output(MLWorks.IO.std_err, str ^ "\n")) arg)

val _ = obey1(MLWorks.arguments());
