(* 
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: _module_dec_io.sml,v $
 * Revision 1.6  1999/03/15 09:21:10  mitchell
 * [Bug #190526]
 * Cope gracefully with missing source files
 *
 *  Revision 1.5  1999/03/11  14:46:22  mitchell
 *  [Bug #190526]
 *  Move dependency precis files to object directory
 *
 *  Revision 1.4  1999/02/18  15:09:36  mitchell
 *  [Bug #190507]
 *  Improve handling of top-level opens.
 *
 *  Revision 1.3  1999/02/15  16:51:59  mitchell
 *  [Bug #190507]
 *  Remove require for __date as it breaks the bootstrap compiler!
 *
 *  Revision 1.2  1999/02/12  15:42:50  sml
 *  [Bug #190507]
 *  Fix require statements
 *
 *  Revision 1.1  1999/02/12  10:15:56  mitchell
 *  new unit
 *  [Bug #190507]
 *  Adding files to support CM-style dependency analysis
 *
 *)
 
require "../basis/__char";
require "../system/__time";
require "../basis/__list";
require "../system/__os";
require "../basis/__text_io";
require "../basis/__string";
require "../main/options";
require "../parser/parser";
require "convert_ast";
require "module_dec_io";

functor ModuleDecIO (structure ConvertAST: CONVERT_AST
                     structure Options: OPTIONS
                     structure Parser : PARSER
  sharing ConvertAST.Absyn = Parser.Absyn
  sharing type Options.options = Parser.Lexer.Options
  ) : MODULE_DEC_IO =
struct
  val version = "MLWorks 2.0\n"

  structure ModuleDec = ConvertAST.ModuleDec
  structure ModuleName = ModuleDec.ModuleName
  structure Lexer = Parser.Lexer
  structure Absyn = Parser.Absyn
  structure Info  = Lexer.Info

  exception FormatError of string

  fun display_dec (dec, output_file) =
    let val st = TextIO.openOut(output_file)
        fun pr s = TextIO.output(st, s)
     in (ModuleDec.display pr dec;
         TextIO.closeOut(st))
    end

  fun do_input filename =
    let
      val options = Options.default_options
      val instream = TextIO.openIn filename
      fun input_fn _ = TextIO.inputN(instream, 4096)
      val token_stream = Lexer.mkTokenStream (input_fn, filename)

      fun until_eof (pB, accum, requires, partial) =
        if Lexer.eof token_stream then
          (accum, requires, partial)
        else
          let val (top_dec, pb) =
                Parser.parse_topdec 
                Info.null_options
                (options, token_stream, pB)
           in case top_dec of
                Absyn.REQUIREtopdec(req, _) => 
                  until_eof (pb,  accum, req :: requires, partial)
              | top_dec =>
                  let val dec = 
                        ConvertAST.convert top_dec
                      val new_accum = case dec of
                                ModuleDec.DecRef set =>
                                  if ModuleName.isEmpty set
                                  then accum
                                  else dec :: accum
                              | _ => dec :: accum
                   in until_eof (pb,  new_accum, requires, partial) 
                  end  
          end handle Parser.SyntaxError _ => (accum, requires, true)
                   | Info.Stop _ => (accum, requires, true)
                   | _ => (print "Unknown exception raised during parsing!\n";
                           (accum, requires, true))
      val (accum, requires, partial) = 
        until_eof (Parser.initial_pB, [], [], false)
      val result = ModuleDec.SeqDec (List.rev accum)
  in
    TextIO.closeIn instream;
    (result, rev requires, partial)
  end

  fun write_decl (s: TextIO.outstream, requires: string list, d: ModuleDec.Dec) = 
      (* We are consing up the whole output as a list of strings
       * before concatenating it to form the final result and
       * wrinting it out using one single `output' call. *)
      let
        fun w_name (n, r) = let
            val ns = ModuleName.namespaceOf n
            val prefix =
                if ns = ModuleName.STRspace then ""
                else if ns = ModuleName.SIGspace then "$"
                     else if ns = ModuleName.FCTspace then "%"
                     else raise (FormatError "w_name")
        in
            prefix :: (ModuleName.nameOf n) :: "." :: r
        end

        fun w_list w (l, r) = foldr w (";" :: r) l

        fun w_path (p, r) = w_list w_name (ModuleName.mnListOfPath p, r)

        fun w_option w (NONE, r) = "-" :: r
          | w_option w (SOME x, r) = "+" :: w (x, r)

        fun w_decl (ModuleDec.StrDec l, r) =
            let
              fun w_item ({ name, def, constraint }, r) =
                  w_name (name,
                          w_strExp (def,
                                    w_option w_strExp (constraint, r)))
            in
              "s" :: w_list w_item (l, r)
            end
          | w_decl (ModuleDec.FctDec l, r) =
            let
              fun w_pitem ((mn, se), r) =
                    w_option w_name (mn, w_strExp (se, r))
              fun w_item ({ name, params, body, constraint }, r) =
                  w_name (name,
                  w_list w_pitem (params,
                  w_strExp (body,
                  w_option w_strExp (constraint, r))))
            in
              "f" :: w_list w_item (l, r)
            end
        | w_decl (ModuleDec.LocalDec (x, y), r) = "l" :: w_decl (x, w_decl (y, r))
        | w_decl (ModuleDec.SeqDec l, r) = "q" :: w_list w_decl (l, r)
        | w_decl (ModuleDec.OpenDec l, r) = "o" :: w_list w_strExp (l, r)
        | w_decl (ModuleDec.DecRef s, r) = "r" :: w_list w_name (ModuleName.makelist s, r)

      and w_strExp (ModuleDec.VarStrExp p, r) = "v" :: w_path (p, r)
        | w_strExp (ModuleDec.BaseStrExp d, r) = "s" :: w_decl (d, r)
        | w_strExp (ModuleDec.AppStrExp (p, l), r) =
            "a" :: w_name (p, w_strExp (l, r))
        | w_strExp (ModuleDec.LetStrExp (d, se), r) =
            "l" :: w_decl (d, w_strExp (se, r))
        | w_strExp (ModuleDec.AugStrExp (se, s), r) =
            "g" :: w_strExp (se, w_list w_name (ModuleName.makelist s, r))
        | w_strExp (ModuleDec.ConStrExp (s1, s2), r) =
            "c" :: w_strExp (s1, w_strExp(s2, r))

      fun w_require(s, r) = s :: "\n" :: r
  in
    TextIO.output (s, concat (version :: 
                              w_list w_require (requires, 
                              w_decl (d, ["\n"]))))
  end

  fun deleteFile name = OS.FileSys.remove name handle _ => ()

  fun create (sourcefile, declfile) = 
      let
        val precis as (decl, requires, partial) = do_input sourcefile
      in
        if partial
        then
          ( deleteFile declfile; precis )
        else
          let val s = TextIO.openOut declfile
           in
              (write_decl (s, requires, decl);
               TextIO.closeOut s;
               precis)
              handle exn => ( TextIO.closeOut s; raise exn )
          end handle exn => ( deleteFile declfile; precis )
      end

  fun complain s = raise (FormatError s)

  fun read_decl s = 
      let
        val vector = TextIO.inputAll s
        val index = ref 0
        val len = String.size vector
        val sub = MLWorks.Internal.Value.unsafe_string_sub
        fun rd () : char option = 
          let val i = !index
           in if i = len 
              then NONE
              else
                (index := i + 1;
                 SOME(MLWorks.Internal.Value.cast(sub(vector, i))))
          end

        fun inputLine () =
          let val start = !index
           in if start = len
              then ""
              else
                ( while (!index < len andalso
                         sub(vector, !index) <> 10) do
                    index := !index + 1;
                  let val i = !index 
                   in if i = len
                      then
                        substring(vector, start, i - start) ^ "\n"
                      else
                        ( index := i + 1;
                          substring(vector, start, i - start + 1) )
                  end )
          end

        local
          fun get (ns, first) = 
              let
                fun loop (accu, NONE) = complain "k1"
                  | loop ([], SOME #".") = complain "k2"
                  | loop (accu, SOME #".") =
                    ModuleName.create (ns, String.implode (rev accu))
                  | loop (accu, SOME s) = loop (s :: accu, rd ())
              in
                loop ([], first)
              end
        in
          fun r_name (SOME #"$") = get (ModuleName.SIGspace, rd ())
            | r_name (SOME #"%") = get (ModuleName.FCTspace, rd ())
            | r_name first = get (ModuleName.STRspace, first)
        end

        fun r_list r =
            let
              fun loop (accu, NONE) = complain "loop 3"
                | loop (accu, SOME #";") = rev accu
                | loop (accu, cur) = loop ((r cur) :: accu, rd ())
            in
              fn first => loop ([], first)
            end

        fun r_path first = ModuleName.pathOfMNList (r_list r_name first)

        fun r_option r (SOME #"-") = NONE
          | r_option r (SOME #"+") = SOME (r (rd ()))
          | r_option r _ = complain "option"

        fun r_decl (SOME #"s") =
            let
                fun r_item first = {
                                    name = r_name first,
                                    def = r_strExp (rd ()),
                                    constraint = r_option r_strExp (rd ())
                                   }
            in
                ModuleDec.StrDec (r_list r_item (rd ()))
            end
          | r_decl (SOME #"f") =
            let
                fun r_param first = (r_option r_name first, r_strExp (rd ()))
                fun r_item first = {
                                    name = r_name first,
                                    params = r_list r_param (rd ()),
                                    body = r_strExp (rd()),
                                    constraint = r_option r_strExp (rd ())
                                   }
            in
                ModuleDec.FctDec (r_list r_item (rd ()))
            end
          | r_decl (SOME #"l") = ModuleDec.LocalDec (r_decl (rd ()), r_decl (rd ()))
          | r_decl (SOME #"q") = ModuleDec.SeqDec (r_list r_decl (rd ()))
          | r_decl (SOME #"o") = ModuleDec.OpenDec (r_list r_strExp (rd ()))
          | r_decl (SOME #"r") = 
              ModuleDec.DecRef (ModuleName.makeset (r_list r_name (rd ())))
          | r_decl _ = complain "decl default"

        and r_strExp (SOME #"v") = ModuleDec.VarStrExp (r_path (rd ()))
          | r_strExp (SOME #"s") = ModuleDec.BaseStrExp (r_decl (rd ()))
          | r_strExp (SOME #"a") =
            ModuleDec.AppStrExp (r_name (rd ()), r_strExp (rd ()))
          | r_strExp (SOME #"l") =
            ModuleDec.LetStrExp (r_decl (rd ()), r_strExp (rd ()))
          | r_strExp (SOME #"g") =
            ModuleDec.AugStrExp (r_strExp (rd ()), ModuleName.makeset (r_list r_name (rd ())))
          | r_strExp (SOME #"c") =
            ModuleDec.ConStrExp (r_strExp (rd ()), r_strExp (rd ()))
          | r_strExp _ = complain "strexp default"

        val firstline = inputLine()
        
        val _ = if firstline = version then () else complain "header"

        fun r_require NONE = ""
          | r_require (SOME first) =
              let val line = inputLine ()
               in String.concat [String.str first,
                                 String.substring(line,
                                                  0, String.size line - 1)]
              end

        val requires = r_list r_require (rd ())

        val r = r_decl (rd ()) 

        val nl = rd ()
    in
        case nl of
          SOME #"\n" => (r, requires) 
        | SOME c => 
            complain ("tail: " ^ (Char.toString c) ^ "\n")
        | NONE => complain "tail"
    end

  fun source_to_module_dec
      ( source_filename : string, source_timestamp: Time.time option,
        object_dir : string )
        :  ModuleDec.Dec * string list * bool =
      let val depend_dir = 
                if OS.FileSys.access(object_dir, [])
                then OS.Path.concat [object_dir, "DEPEND"]
                else 
                  ( print("Unable to find directory " ^ object_dir ^ "\n");
                    raise OS.SysErr("Unable to find directory " ^ object_dir,
                                    NONE) )
          val depend_file =
                OS.Path.concat[depend_dir, OS.Path.file source_filename]
       in if OS.FileSys.access(depend_dir, [])
          then ()
          else OS.FileSys.mkDir depend_dir;

          let 
            val result = 
              case source_timestamp of
                SOME timestamp =>
                  if OS.FileSys.access(depend_file, [])
                  then 
                    if (Time.<(OS.FileSys.modTime depend_file, timestamp))
                    then
                      create (source_filename, depend_file) 
                    else
                      let val st = TextIO.openIn depend_file
                       in let val (decls,requires) = read_decl st
                              val _ = TextIO.closeIn st
                           in (decls, requires, false)
                          end 
                          handle FormatError s => 
                                   (print ("Dependency format error: " ^ s ^ "\n");
                                    print ("Rebuilding " ^
                                           depend_file ^ "\n");
                                    TextIO.closeIn st;
                                    create (source_filename, depend_file))
                      end handle _ => 
                            ( print ("Cannot open " ^            
                                     depend_file ^ " - rebuilding.\n");
                              create (source_filename, depend_file))
                  else 
                    create (source_filename, depend_file)
              | NONE =>
                  let fun depend_error () =
                      ( print("Unable to process " ^ depend_file ^ "\n");
                        (ModuleDec.SeqDec [], [], true) )
                   in if OS.FileSys.access(depend_file, [])
                      then 
                        let val st = TextIO.openIn depend_file
                         in let val (decls,requires) = read_decl st
                                val _ = TextIO.closeIn st
                             in (decls, requires, false)
                            end 
                            handle FormatError s => 
                               (print ("Dependency format error: " ^ s ^ "\n");
                                TextIO.closeIn st;
                                depend_error())
                        end handle _ => depend_error()
                      else 
                        (* If there is no source file and no dependency file
                           then we assume the file is just an orphan in the
                           project file and just ignore it *)
                        (ModuleDec.SeqDec [], [], true)
                  end
          in result
          end
      end


(* Do we need to worry about stable files?  Not yet...
    datatype member =
	ENTITY of { name: AbsPath.t, class: string }
      | FILE of { name: AbsPath.t, decl: MD.decl }

    fun write_fname (s, { name, rigid, context }) = let
	fun esc (#"\\", r) = #"\\" :: #"\\" :: r
	  | esc (#"\n", r) = #"\\" :: #"n" :: r
	  | esc (c, r) = c :: r
	val chars = foldr esc [#"\n"] (explode name)
	val chars = (if rigid then #"!" else #"?") :: chars
    in
	TextIO.output (s, implode chars)
    end

    fun write_member s (ENTITY { name, class }) =
	(write_fname (s, AbsPath.spec name);
	 TextIO.output (s, concat ["Class ", class, "\n"]))
      | write_member s (FILE { name, decl }) =
	(write_fname (s, AbsPath.spec name);
	 TextIO.output (s, "Stable\n");
	 write_decl (s, decl))

    fun write_members (s, ml) = app (write_member s) ml

    fun create_stable (ml, stablefile) = let
	val s = openTextOut stablefile
	val _ = Interrupt.guarded (fn () => write_members (s, ml))
	    handle exn => (TextIO.closeOut s; raise exn)
    in
	TextIO.closeOut s
    end handle exn => let
	val stablestring = AbsPath.elab stablefile
    in
	deleteFile stablestring;
	Control.say (concat ["writing ", stablestring, " failed]\n"]);
	raise exn
    end
*)

end




