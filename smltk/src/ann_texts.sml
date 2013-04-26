(* ***************************************************************************
 
   $Source: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/smltk/src/RCS/ann_texts.sml,v $
 
   Annotated texts for the sml_tk markup language.

   $Date: 1999/06/16 09:51:26 $
   $Revision: 1.1 $
   Author: cxl (Last modification by $Author: johnh $)

   (C) 1996, 1998, Bremen Institute for Safe Systems, Universitaet Bremen
 
  ************************************************************************** *)

require "__int";
require "__substring";

require "basic_util";
require "basic_types";
require "ann_texts_sig";

structure AnnotatedText : ANNOTATED_TEXT = 

struct 

    infix 6 ++  (* see below -- fixity decl's not allowed inside signatures *)

    open BasicTypes BasicUtil


    (* The two int's are the index to the last character/last row of the 
     * text. This index is calculated `lazy'-- i.e. if it is not given 
     * explicitly, it is only calculated if another annotated text with
     * a non-empty list of annotations is appended to the text. (Yes, bloody
     * clever I know.)
     *

    datatype AnnoText =  
	AnnoText of (int* int) Option.option* string* Annotation list 

     * This has gone to BasicTypes. *)
	        			
    fun selText (AnnoText(_, t, _))= t
    fun selAnno (AnnoText(_, _, a))= a
    fun updAnno (AnnoText(x, t, _)) a = AnnoText(x, t, a)

    (* adding columns-- a wee bit funny, since counting starts at one
     * but we want to be graceful about column zero as well. *)
    fun addCols(c1, c2) = c1+c2- (Int.min(c1, 1))

    fun add2Mark (c, r) (Mark(cm, rm)) = if (c<= 1) then Mark(c, r+rm)
					 else Mark(addCols(c, cm), rm)
      | add2Mark (c, r) (MarkToEnd cm) = MarkToEnd(addCols(c, cm))
      | add2Mark (c, r) MarkEnd        = MarkEnd

    fun pair f (x, y) = (f x, f y)  (* has gone into BasicUtil *)

    fun mapMark f (TATag(aid, marks, conf, binds)) =
		 TATag(aid, map (pair f) marks, conf, binds)
      | mapMark f (TAWidget(aid, mark, wid, wids, co1, co2, binds)) =
	         TAWidget(aid, f mark, wid, wids, co1, co2, binds)

    (* concatenate two annotated texts with explicit length *)
    fun cat ((cols, rows), s, a) ((cols0, rows0), t, b) =
	let val ann = a@(map (mapMark (add2Mark (cols, rows))) b)
	              (* a wee bit debatable-- we might want to adjust the 
		       * "End" etc. marks in the annotations of the first
		       * text. Then again, end means end *)
	in  if cols0 <= 1 (* second text only has one line, we only add rows *)
		then AnnoText(SOME(cols, rows+rows0), s^t, ann)
	    else
		AnnoText(SOME(addCols(cols, cols0), rows0), s^t, ann)
	end                    

    (* count length of annotated text *)
    fun lenAT t =
	   let fun cnt (thischar, (line, char)) =
	       if (StringUtil.isLinefeed thischar) 
		   then (line+1, 0)
	       else (line, char+1)
	       val (cols, rows) = Substring.foldl cnt (0, 0) (Substring.all t)
	   in (Int.max(cols, 1), rows)
	   end
	
    		 
    fun ((AnnoText(len, s, a))  ++ (AnnoText(_ , "", b))) =
         AnnoText(len, s, a) 
      | ((AnnoText(NONE, s, a)) ++ (AnnoText(NONE, t, []))) =
	 AnnoText(NONE, s^t, a) 
      | ((AnnoText(len1, s, a)) ++ (AnnoText(len2, t, b))) =
	 let fun get_len (SOME(c, r), s, a) = ((c, r), s, a)
	       | get_len (NONE, s, a)       = (lenAT s, s, a)
	 in  cat (get_len(len1, s, a)) (get_len(len2, t, b))
	 end


    fun nl(AnnoText(NONE, s, a))       = AnnoText(NONE, s^"\n", a)
      | nl(AnnoText(SOME(c, r), s, a)) = AnnoText(SOME(c+1, 0), s^"\n", a)

    val mtAT = AnnoText(NONE, "", [])


   (* convert a string to an annotated text with no annotations *)
    fun mk str = AnnoText(NONE, str, [])

    fun concatATWith str ls = 
	let val at = mk str
	    fun concatWith' []      = mtAT
	      | concatWith' [t]     = t
	      | concatWith' (t::ts) = t++at++(concatWith' ts)
	in  concatWith' ls
	end

    (* fun replaceTextWidAnnText wid (AnnoText(_, t, a))=
	SmlTk.replaceTextWidText wid t a *)

end







