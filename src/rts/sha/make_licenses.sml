(* 
 * This is a simple program for automatically generating MLWorks licenses.
 *
 * We generate "unique" names and then call mlw_mklic to construct the 
 * corresponding codes.  Because of this dependence on mlw_mklic we need to
 * alter this program whenever the interface to mlw_mklic changes.
 * Calling mlw_mklic for each license is the bottleneck, so no attempt has 
 * been made to optimize the code in this driver program.
 *
 * We want names to give an indication of the platform and edition.  
 * We also want them to be unique.  We achieve the uniqueness,
 * up to a point, by encoding the startup time of the application in the name. 
 * This will only cause duplicates if someone else runs the program at the same
 * time to the second.  This seems pretty unlikely, so we haven't encoded an
 * IP address, or something similar, in the code.  But we allow an optional
 * command-line string to be added to the name to improve uniqueness in cases
 * where this may be an issue.  To allow multiple licenses to be generated at
 * once, names also contain a sequence number.  So the general form is
 * 
 *     ML{edition}-{platform}-{time}{sequence#}[-{optional-tag}]
 * 
 * $Log: make_licenses.sml,v $
 * Revision 1.4  1999/03/12 10:10:26  mitchell
 * [Bug #190509]
 * Update version strings for 2.1
 *
# Revision 1.3  1998/08/03  14:03:59  jkbrook
# [Bug #30457]
# Change platform groupings to reflect pricing not OS
#
# Revision 1.2  1998/07/21  16:47:10  jkbrook
# [Bug #30436]
# Updated edition names in mlw_mklic
#
# Revision 1.1  1998/07/07  09:32:40  mitchell
# new unit
# [Bug #30437]
# A simple front-end for mlw_mklic for automatically generating licenses
#
 * 
 * Copyright (c) 1998 Harlequin Ltd.
 * 
 *)

datatype Platform = Win95 | NT | Linux | Solaris | Irix

fun platform_to_string Win95   = "W95"
  | platform_to_string NT      = "WNT"
  | platform_to_string Linux   = "LNX"
  | platform_to_string Solaris = "SOL"
  | platform_to_string Irix    = "IRX"

datatype Edition = Personal | Professional | Enterprise

fun edition_to_string Personal     = "PER"
  | edition_to_string Professional = "PRO"
  | edition_to_string Enterprise   = "ENT"


(* 
 * Numbers are encoded in base 32, as we use just uppercase letters and
 * numbers to minimise user confusion.  Furthermore, we use @ instead of 0,
 * and % instead of 1, just like the license generator does. The current time 
 * is encoded as an offset, in seconds, from the beginning of 1998.
 *)

val base = 32;
val base_sqr = base * base;

val base_char_vector =
  Vector.fromList (String.explode "@%23456789ABCDEFGHIJKLMNOPQRSTUV")

(* Convert a number to a string, base 32 *)
fun num_to_string n =  
    let val d = Int.div(n, base)
        val prefix = if d = 0 then "" else num_to_string d 
     in prefix ^ Char.toString(Vector.sub(base_char_vector, Int.mod(n, base)))
    end

(* Convert the current time into an offset, in seconds from start of 1998 *)
fun seconds () =
  let open Date 
      val date = fromTimeUniv(Time.now())
      val secs =
        60 * ( 60 * ( 24 * ( 365 * (year date - 1998)
                             + (yearDay date) )
                      + (hour date) )
               + (minute date) )
        + (second date)
  in secs end;

(* Create a list of license names *)
fun create_seq_names (platform, edition, how_many, start_time, suffix) =
  let val now = num_to_string(start_time)
      val platform_string = platform_to_string platform
      val edition_string = edition_to_string edition
      val common_prefix = "ML" ^ edition_string ^ "-" ^ platform_string 
                          ^ "-" ^ now 
      fun generate n =
            if n > how_many then []
            else (common_prefix ^ (num_to_string (Int.div(n,base)))
                                ^ (num_to_string (Int.mod(n,base)))
                                ^ suffix)
                 :: (generate (n + 1))
   in generate 1 
  end;

(* 
 * We only use two characters for the sequence number, so if a very large
 * number of licenses are created in one go we increment the time after 
 * generating each chunk of base_sqr names.
 *)
fun create_names (platform, edition, how_many, suffix) =
  let fun loop (n, t) =
        if (n <= base_sqr) 
        then create_seq_names (platform, edition, n, t, suffix)
        else (create_seq_names (platform, edition, base_sqr, t, suffix)) @
             (loop (n - base_sqr, t + 1))
   in loop(how_many, seconds())
  end;

(* 
 * We use mlw_mklic to generate the code corresponding to each name.  For 
 * portability we use OS.Process.system to call it, but as this only passes 
 * back success or failure as a result we use a temporary file to pass back 
 * the code.
 *)
exception System;

fun system command =
  let val tmp_name = OS.FileSys.tmpName()
      val command' = command ^ " > " ^ tmp_name
   in if OS.Process.system command' = OS.Process.success
      then 
        let val stream = TextIO.openIn tmp_name
            val result = TextIO.inputAll stream
         in TextIO.closeIn stream; 
            OS.FileSys.remove tmp_name; 
            result
        end
      else raise System
  end;

(* 
 * This is the function that actually produces the code corresponding to a 
 * name. The function assumes the code itself is enclosed within quotes
 * when returned by mlw_mklic
 *)
fun create_license (mlw_mklic, platform, edition) name =
  let val type_string  = "v2.1"
      val install_date = "010405"  (* We don't want these licenses to expire *)
      val expiry_date  = "300622"  (* so pick some time a long way off, e.g. *)
                                   (* when I retire...                       *)
      val platform_string =
            case platform of 
              Win95   => "win95"
            | NT      => "nt"
            | Linux   => "linux"
            | Solaris => "solaris"
            | Irix    => "irix"

       val edition_string =
            case edition of
              Personal     => "personal"      
            | Professional => "professional"
            | Enterprise   => "enterprise"

       val result = system (
                         mlw_mklic ^ " " 
                       ^ type_string ^ " "
                       ^ platform_string ^ " "
                       ^ name ^ " "
                       ^ edition_string ^ " "
                       ^ install_date ^ " "
                       ^ expiry_date)

       val l = String.tokens (fn c => c = #"'" orelse c = #"`") result
   in List.nth(l, 1) (* The code is prefixed by some text *)
  end;
     
(* Construct a list of (name,code) pairs *)
fun create_licenses (mlw_mklic, platform, edition, how_many, suffix) =
  let val names = create_names (platform, edition, how_many, suffix)
      val codes = map (create_license (mlw_mklic, platform, edition)) names
   in ListPair.zip(names, codes) end;

(* Output a list of (name,code) pairs *)
fun print_code_with_spaces code =
  (* The license validation functions can't cope with spaces at the moment, 
   * so just print the code without spaces for now. *) 
  print code
(*let fun pr([],_) = ()
        | pr(c::rest, n) =
           ( if (n > 0 andalso Int.mod(n, 3) = 0) then print " " else ();
             print (Char.toString c);
             pr(rest, n + 1) )
   in pr(explode code, 0)
  end;
*)
  
fun print_licenses [] = ()
  | print_licenses ((n,c) :: t) =
      (print n; print "\t"; print_code_with_spaces c; print "\n";
       print_licenses t);


(* 
 * We need to process the command-line arguments so we know which licenses 
 * to generate.  We don't do anything too sophisticated here, as users won't be
 * running this code.
 *)
  
exception CommandArguments

fun string_to_platform "win95"   = Win95
  | string_to_platform "nt"      = NT
  | string_to_platform "linux"   = Linux
  | string_to_platform "solaris" = Solaris
  | string_to_platform "irix"    = Irix
  | string_to_platform _         = raise CommandArguments

fun string_to_edition "personal"     = Personal
  | string_to_edition "professional" = Professional
  | string_to_edition "enterprise"   = Enterprise
  | string_to_edition _              = raise CommandArguments
  
(* We assume that mlw_mklic is in the same directory as the current program *)
fun locate_mlw_mklic program =
  let val dir = OS.Path.dir program
      val ext = OS.Path.ext(OS.Path.file program)
      val mklic_file = OS.Path.joinBaseExt {base = "mlw_mklic", ext = ext}
      val program = OS.Path.joinDirFile {dir = OS.Path.dir program,
                                         file = mklic_file}
   in if OS.FileSys.access(program, [])
      then program
      else (print ("Cannot find the application " ^ program ^ "\n");
            raise CommandArguments)
  end
  
fun main arguments =
  ( if length arguments < 4 then raise CommandArguments
    else
      let val program :: platform :: edition :: count :: rest = arguments
          val mlw_mklic = locate_mlw_mklic program
          val platform = 
            string_to_platform (implode (map Char.toLower (explode platform)))
          val edition = 
            string_to_edition (implode (map Char.toLower (explode edition)))
          val count = valOf(Int.fromString count) 
                        handle _ => raise CommandArguments
          val suffix = if rest = nil then "" else "-" ^ (List.hd rest)
       in print_licenses(
            create_licenses (mlw_mklic, platform, edition, count, suffix));
          ignore(OS.Process.exit (OS.Process.success)); ()
      end
  ) handle _ =>
    ( print (
 "This program takes \"platform\", \"edition\" and \"number\" as arguments,\n"
^"where the program must be in the same directory as the license generator,\n"
^"platform is one of Win95, NT, Linux, Solaris or Irix,\n"
^"edition is one of Personal, Professional or Enterprise, and\n"
^"number is the number of licenses you wish to generate.\n");
      OS.Process.exit (OS.Process.failure) );


(* Finally let's deliver the application and run away... *)

MLWorks.Deliver.deliver(
  "make_licenses",
  fn () => main(CommandLine.name() :: CommandLine.arguments()),
  MLWorks.Deliver.CONSOLE);










