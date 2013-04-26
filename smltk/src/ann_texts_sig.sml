(* ***************************************************************************
 
   $Source: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/smltk/src/RCS/ann_texts_sig.sml,v $
 
   Annotated texts for sml_tk.

   $Date: 1999/06/16 09:51:28 $
   $Revision: 1.1 $
   Author: cxl (Last modification by $Author: johnh $)

   (C) 1996, Bremen Institute for Safe Systems, Universitaet Bremen
 
  ************************************************************************** *)

require "basic_types";

signature ANNOTATED_TEXT =
    sig
	(* This type represents annotated texts. *)
	(* type AnnoText *)

        (* selectors *)
        val selText  : BasicTypes.AnnoText -> string
        val selAnno  : BasicTypes.AnnoText -> BasicTypes.Annotation list
	val updAnno  : BasicTypes.AnnoText -> BasicTypes.Annotation list 
	                                             -> BasicTypes.AnnoText


	(* The empty annotated text *)
	val mtAT : BasicTypes.AnnoText 

	(* Concatenate annotated texts, keeping track of the annotations. *)
	val ++ : BasicTypes.AnnoText * BasicTypes.AnnoText -> BasicTypes.AnnoText

	(* add a new line at the end *)
	val nl : BasicTypes.AnnoText -> BasicTypes.AnnoText

	(* make a string into an annotated text with no annotations *)
	val mk : string   -> BasicTypes.AnnoText

	(* like concatWith from BasicUtil *)
	val concatATWith : string -> BasicTypes.AnnoText list 
	                                                -> BasicTypes.AnnoText 

	(* utility function *)
	(* val replaceTextWidAnnText : TkTypes.WidId-> BasicTypes.AnnoText-> unit *)

    end
