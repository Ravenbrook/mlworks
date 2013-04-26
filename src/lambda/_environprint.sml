(* _environprint.sml the functor *)
(*
$Log: _environprint.sml,v $
Revision 1.22  1997/05/22 13:12:07  jont
[Bug #30090]
Replace MLWorks.IO with TextIO where applicable

 * Revision 1.21  1996/04/30  16:15:03  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.20  1995/03/22  13:52:50  daveb
 * Removed unused parameter Types.
 *
Revision 1.19  1994/10/03  13:43:55  matthew
Lambdatypes changes

Revision 1.18  1994/02/21  18:42:16  nosa
generate_moduler compiler option in strenvs and funenvs for compatibility purposes.

Revision 1.17  1994/01/19  12:38:20  nosa
Paths in LAMBs for dynamic pattern-redundancy reporting

Revision 1.16  1993/07/07  16:51:59  daveb
Funenvs no longer have interface components.

Revision 1.15  1993/03/10  16:41:34  matthew
Signature revisions

Revision 1.14  1993/03/04  12:37:35  matthew
Options & Info changes

Revision 1.13  1993/01/05  16:31:44  jont
Added functions to print directly to a supplied stream

Revision 1.12  1992/11/26  14:05:21  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.11  1992/08/26  12:06:22  jont
Removed some redundant structures and sharing

Revision 1.10  1992/08/12  11:49:45  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.9  1992/08/05  17:45:39  jont
Removed some structures and sharing

Revision 1.8  1992/06/15  16:58:16  jont
Added EXTERNAL constructor to COMP

Revision 1.7  1992/06/10  17:47:47  jont
Changed to use newmap

Revision 1.6  1992/02/11  10:29:49  clive
New pervasive library

Revision 1.5  1991/07/19  16:44:31  davida
New version using custom pretty-printer

Revision 1.4  91/07/12  17:47:11  jont
Updated to print top level environments

Revision 1.3  91/06/27  13:17:42  jont
Improved output format to get names and values on the same line

Revision 1.2  91/06/12  19:33:00  jont
Split environtypes from environ

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "^.basis.__text_io";

require "pretty";
require "environ";
require "environprint";
require "../basics/identprint";

functor EnvironPrint(
  structure Pretty : PRETTY
  structure IdentPrint : IDENTPRINT
  structure Environ: ENVIRON

  sharing IdentPrint.Ident = Environ.EnvironTypes.LambdaTypes.Ident
) : ENVIRONPRINT =
struct

  structure P = Pretty
  structure IP = IdentPrint
  structure EnvironTypes = Environ.EnvironTypes
  structure LambdaTypes = EnvironTypes.LambdaTypes
  structure NewMap = EnvironTypes.NewMap
  structure Options = IdentPrint.Options

  fun decodecomp x = 
      P.blk(0,
	    case x of
		EnvironTypes.LAMB (lvar,_) => 
		    [P.str "LAMB ",
		     P.str (LambdaTypes.printLVar lvar)]

	      | EnvironTypes.FIELD {size,index} => 
		    [P.str "FIELD ",
		     P.str (LambdaTypes.printField {size=size,index=index,selecttype=LambdaTypes.TUPLE})]

	      | EnvironTypes.PRIM prim => 
		    [P.str "PRIM ",
		     P.str (LambdaTypes.printPrim prim)]
	      | EnvironTypes.EXTERNAL => [P.str"EXTERNAL"])
		    
  fun envir_block l =  P.blk(1,
			     [P.str "{"] @ 
			     (P.lst("", [P.str ",", P.brk 1], "") l) @
			     [P.str " }"]);

  fun decodeenv options (x as EnvironTypes.ENV(valids, strids)) = 
      let
	  fun decode_valid_list l = 
	     let 
		 fun tof (valid,comp) = P.blk(2, 
					      [P.str " ",
					       P.str (IP.printValId options valid), 
					       P.str " --> ",
					       decodecomp comp])
	     in 
		 envir_block (map tof l)
	     end

	  fun decode_strid_list l =
	      let
		  fun tof (strid, (env, comp, _)) =
		      P.blk(0, 
			    [P.str " ",
			     P.str (IP.printStrId strid),
			     P.str " --> ",
			     decodecomp comp,
			     P.blk(0,[P.str " ",
				      decodeenv options env])])
	      in
		  P.blk(1, [P.str "{"] @ 
			    (P.lst("", [P.brk 2], "") (map tof l)) @
			    [P.str " }"])
	      end;

      in
	  P.blk(0,
		[P.str " VE: ",
		 P.blk(0, [decode_valid_list (NewMap.to_list_ordered valids)]),
		 P.nl,
		 P.str " SE: ",
		 P.blk(0, [decode_strid_list (NewMap.to_list_ordered strids)])])
      end;

  fun stringenv options env = P.string_of_T (decodeenv options env);

  fun printenv options env stream =
    P.print_T (fn x => TextIO.output(stream, x)) (decodeenv options env)

  fun decodetopenv options (EnvironTypes.TOP_ENV(env, EnvironTypes.FUN_ENV fun_env)) =
      let 
	  fun decode_functor_list l = 
	    let 
	      fun tof (funid, (c, e, _)) = 
		  P.blk(2, [P.str (IP.printFunId funid),
			    P.str " --> ",
			    P.blk(0, 
				  [decodecomp c,
				   P.nl,
				   P.str "ResEnv: ",
				   P.blk(0, [decodeenv options e])])])
	    in 
		envir_block (map tof l)
	    end;
      in
	  P.blk(0,
		[P.str " Ftr: ",
		 P.blk(0, [decode_functor_list (NewMap.to_list_ordered fun_env)]),
		 P.nl,
		 P.str " Top:",
		 P.blk(0, [decodeenv options env])])
      end;
      
  fun stringtopenv options env = P.string_of_T (decodetopenv options env);

  fun printtopenv options env stream =
    P.print_T (fn x => TextIO.output(stream, x)) (decodetopenv options env)

end
