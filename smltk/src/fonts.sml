(* ***************************************************************************
 
   $Source: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/smltk/src/RCS/fonts.sml,v $

   Fonts for sml_tk.
  
   This module tries to provide a wee bit more abstract approach to
   specifying fonts than as in "-*-bollocks-*-*-37-" X-style font
   description.
 
   $Date: 1999/06/16 10:02:10 $
   $Revision: 1.1 $
   Author: cxl (Last modification by $Author: johnh $)

   (C) 1997, Bremen Institute for Safe Systems, Universitaet Bremen
 
  ************************************************************************** *)

require "__int";
require "__real";
require "__list";
require "__text_io";

require "basic_util";
require "sys_conf";
require "debug";
require "fonts_sig";

structure Fonts : FONTS_SIG =
struct

   open BasicUtil
	 
   val Config = 
       {Normalfont = ref "-*-courier",
	Typewriter = ref "-misc-fixed",              (* "-*-lucidatypewriter", *)
	SansSerif  = ref "-*-helvetica",
	Symbol     = ref "-*-symbol",
	BaseSize   = ref 12,
	ExactMatch = ref true,
	Resolution = ref 75
	}

    datatype FontConfig =
	Bold | Italic | 
	Tiny | Small | NormalSize | Large | Huge |
	Scale of real

	
   val InitConfig =
       { NormalFn'      = ref (fn (b:bool,it:bool) => ((!(#Normalfont(Config)) ^ "-*-*-*-*")) ),
         TypewriterFn'  = ref (fn (b:bool,it:bool) => ((!(#Typewriter(Config)) ^ "-*-*-*-*")) ),
	 SansSerifFn'   = ref (fn (b:bool,it:bool) => ((!(#SansSerif(Config))  ^ "-*-*-*-*")) ),
	 SymbolFn'      = ref (fn (b:bool,it:bool) => ((!(#Symbol(Config))     ^ "-*-*-*-*")) )
	 }


    datatype Font = 
	XFont of string  
      | Normalfont of FontConfig list      
      | Typewriter of FontConfig list 
      | SansSerif of  FontConfig list
      | Symbol of     FontConfig list
    (*   should have more here ... *)


    (* selector function *)
    fun selFontConf (Normalfont c)    = c
      | selFontConf (Typewriter c)= c
      | selFontConf (SansSerif c) = c
      | selFontConf (Symbol c)    = c
      | selFontConf (XFont _)     = [] (* should raise exception ?! *)

    (* update function *)
    fun updFontConf((Normalfont _), c)    = Normalfont c
      | updFontConf((Typewriter _), c)= Typewriter c
      | updFontConf((SansSerif _), c) = SansSerif c
      | updFontConf((Symbol _), c)    = Symbol c
      | updFontConf((XFont str), _)   = XFont str (* should raise exception ?! *)

    fun isBold Bold     = true
      | isBold _        = false
    fun isItalic Italic = true
      | isItalic _      = false

    exception NoSize

    fun sizeOf Tiny      = 10.0 / 14.0
      | sizeOf Small     = 12.0 / 14.0
      | sizeOf NormalSize= 14.0 / 14.0
      | sizeOf Large     = 18.0 / 14.0
      | sizeOf Huge      = 24.0 / 14.0
      | sizeOf (Scale s) = s
      | sizeOf _         = raise NoSize

    fun descrFromInitConfig family true true =
	family^"-bold-o-*-*"
      | descrFromInitConfig family true false =
	family^"-bold-r-*-*"
      | descrFromInitConfig family false true =
	family^"-medium-o-*-*"
      | descrFromInitConfig family false false =
	family^"-medium-r-*-*"
	

    fun checkFont fntStr = not (FileUtil.exec (SysConf.getFontPath(),[fntStr]))

    fun addOneFont fr fam =
	let
	    val fstr = descrFromInitConfig fam
	    fun addOne b it =
		if (checkFont (fstr b it)) then
		    let
			val fr' = !fr
		    in
			fr := (fn (b',it') => 
			       if ( b = b' andalso it = it' ) then
				   (fstr b it)
			       else
		                   (fr')(b',it') )
		    end
		else
		    Debug.warning("Could not find font \"" ^ (fstr b it) ^ 
				  "\"; installing default.")
	in
	    addOne true true;
	    addOne true false;
	    addOne false true;
	    addOne false false
	end


   val FinalConfig =
       { NormalFn      = ref (fn (b,it,p:int) => ((* addOneFont (#NormalFn'(InitConfig)) (#Normalfont(!Config)); *)
						  ( (!(#NormalFn'(InitConfig))) (b,it) ) ^ "-*-*-*-*-*-*-*-*" )),
         TypewriterFn  = ref (fn (b,it,p:int) => ((* addOneFont (#TypewriterFn'(InitConfig)) (#Typewriter(!Config)); *)
						  ( (!(#TypewriterFn'(InitConfig))) (b,it) ) ^ "-*-*-*-*-*-*-*-*" )),
	 SansSerifFn   = ref (fn (b,it,p:int) => ((* addOneFont (#SansSerifFn'(InitConfig)) (#SansSerif(!Config)); *)
						  ( (!(#SansSerifFn'(InitConfig))) (b,it) ) ^ "-*-*-*-*-*-*-*-*" )),
	 SymbolFn      = ref (fn (b,it,p:int) => ((* addOneFont (#SymbolFn'(InitConfig)) (#Symbol(!Config)); *)
						  ( (!(#SymbolFn'(InitConfig))) (b,it) ) ^ "-*-*-*-*-*-*-*-*" ))
	 }


    fun descrFromFinalConfig fam b it sz =
	((!fam) (b,it)) ^ "-" ^ (Int.toString sz) ^ "-*-*-*-*-*-*-*"

    fun descrFromFinalConfigTest fam b it sz =
	(* wenn man den vollen String, wie in descrFromFinalConfig,
         * zum Testen benutzt, funktioniert xlsfonts leider nicht.
         *)
	((!fam) (b,it)) ^ "-" ^ (Int.toString sz) ^ "-*"

    fun addOneFontSize fr iniFr =
	let
	    val fstr  = descrFromFinalConfig (iniFr)
	    val fstrt = if ( !(#ExactMatch(Config)) ) then
		            descrFromFinalConfigTest (iniFr)
			else
			    descrFromFinalConfig (iniFr)

	    fun addDefault fr =
		let
		    val fr' = !fr
		in
		    fr := (fn (b,it,sz) => ((!iniFr)(b,it))^"-*-*-*-*-*-*-*-*" )
		end

	    fun findOne b it sz []     = NONE
	      | findOne b it sz (x::xl) = 
		if (checkFont (fstrt b it (sz+x))) then
		    SOME (fstr b it (sz+x))
		else
		    findOne b it sz xl

	    fun addOne b it szIn dlst =
		let
		    val sz  = (Real.round(Real.* (Real.fromInt(!(#BaseSize(Config))), (sizeOf szIn))))
		    val str = findOne b it sz dlst
		in
		    case str of
			NONE    => Debug.warning("Could not find font \"" ^ (fstr b it sz) ^ "\"; installing default.")
		      | SOME fs => 
			    let
				val fr' = !fr
			    in
				fr := (fn (b',it',sz') => 
				       if ( b = b' andalso it = it' andalso sz = sz' ) then
					   (Debug.print 13 ("Found FontSize: "^(fstr b' it' sz')^"\n");
					    fs )
				       else
					   (Debug.print 12 ("Descending FontSize: "^(fstr b' it' sz')^"\n");
					    (fr')(b',it',sz')) )
			    end
		end
	in
(*	    addDefault fr;
 *)
	    addOne true  true  Tiny [0,~1,1];
	    addOne true  false Tiny [0,~1,1];
	    addOne false true  Tiny [0,~1,1];
	    addOne false false Tiny [0,~1,1];

	    addOne true  true  Small [0,~1,1,~2,2];
	    addOne true  false Small [0,~1,1,~2,2];
	    addOne false true  Small [0,~1,1,~2,2];
	    addOne false false Small [0,~1,1,~2,2];

	    addOne true  true  Large [0,~1,1,~2,2,3];
	    addOne true  false Large [0,~1,1,~2,2,3];
	    addOne false true  Large [0,~1,1,~2,2,3];
	    addOne false false Large [0,~1,1,~2,2,3];

	    addOne true  true  Huge [0,~1,1,~2,2,3,4,5];
	    addOne true  false Huge [0,~1,1,~2,2,3,4,5];
	    addOne false true  Huge [0,~1,1,~2,2,3,4,5];
	    addOne false false Huge [0,~1,1,~2,2,3,4,5];

	    addOne true  true  NormalSize [0,~1,1,~2,2];
	    addOne true  false NormalSize [0,~1,1,~2,2];
	    addOne false true  NormalSize [0,~1,1,~2,2];
	    addOne false false NormalSize [0,~1,1,~2,2]
	end


    fun descrFromConfig (family, conf) = 
	let val wght = (List.exists isBold) conf	    
	    val slant= (List.exists isItalic) conf
	    val size =
		let fun sizeFold(c, rest) =
		        (sizeOf c) 
			handle NoSize => rest
		in 
		    foldr sizeFold 1.000 conf
		end
	    val pxlsz = (Real.round(
			       Real.* (Real.fromInt(!(#BaseSize(Config))), size)))
	    val str = (!(family(FinalConfig))) (wght,slant,pxlsz)
	in
	    Debug.print 13 ("descrFromConfig: "^str^"\n");
	    str
	end


    fun fontDescr (XFont str)      = str
      | fontDescr (Normalfont conf)= descrFromConfig(#NormalFn, conf)
      | fontDescr (Typewriter conf)= descrFromConfig(#TypewriterFn, conf)
      | fontDescr (SansSerif conf) = descrFromConfig(#SansSerifFn, conf)
      | fontDescr (Symbol conf)    = descrFromConfig(#SymbolFn, conf)

    
    fun init () =
	(* This should 
	 * - check if all possible fonts exists 
	 * - if not, find some `close matches'. This is particularly
	 *   important for the size.
         * - and remember them for future reference. 
	 *)

(*
	let
	    val normal  = !(#Normalfont(Config))
	    val typewr  = !(#Typewriter(Config))
	    val sans    = !(#SansSerif(Config))
	    val symbol  = !(#Symbol(Config))
	in
	    TextIO.output(TextIO.stdOut, "Configuring fonts-- this may take a wee while..."); 	   
	    addOneFont (#NormalFn'(InitConfig)) normal;
	    addOneFont (#TypewriterFn'(InitConfig)) typewr;
	    addOneFont (#SansSerifFn'(InitConfig)) sans;
	    addOneFont (#SymbolFn'(InitConfig)) symbol;

	    Debug.print 13 ( ( (!(#NormalFn'(InitConfig)))(true,true) )^"\n");
	    Debug.print 13 ( ( (!(#NormalFn'(InitConfig)))(true,false) )^"\n");
	    Debug.print 13 ( ( (!(#NormalFn'(InitConfig)))(false,true) )^"\n");
	    Debug.print 13 ( ( (!(#NormalFn'(InitConfig)))(false,false) )^"\n");

	    Debug.print 13 ( ( (!(#TypewriterFn'(InitConfig)))(true,true) )^"\n");
	    Debug.print 13 ( ( (!(#TypewriterFn'(InitConfig)))(true,false) )^"\n");
	    Debug.print 13 ( ( (!(#TypewriterFn'(InitConfig)))(false,true) )^"\n");
	    Debug.print 13 ( ( (!(#TypewriterFn'(InitConfig)))(false,false) )^"\n");

	    Debug.print 13 ( ( (!(#SansSerifFn'(InitConfig)))(true,true) )^"\n");
	    Debug.print 13 ( ( (!(#SansSerifFn'(InitConfig)))(true,false) )^"\n");
	    Debug.print 13 ( ( (!(#SansSerifFn'(InitConfig)))(false,true) )^"\n");
	    Debug.print 13 ( ( (!(#SansSerifFn'(InitConfig)))(false,false) )^"\n");

	    Debug.print 13 ( ( (!(#SymbolFn'(InitConfig)))(true,true) )^"\n");
	    Debug.print 13 ( ( (!(#SymbolFn'(InitConfig)))(true,false) )^"\n");
	    Debug.print 13 ( ( (!(#SymbolFn'(InitConfig)))(false,true) )^"\n");
	    Debug.print 13 ( ( (!(#SymbolFn'(InitConfig)))(false,false) )^"\n");

	    addOneFontSize (#NormalFn(FinalConfig)) (#NormalFn'(InitConfig));
	    addOneFontSize (#TypewriterFn(FinalConfig)) (#TypewriterFn'(InitConfig));
	    addOneFontSize (#SansSerifFn(FinalConfig)) (#SansSerifFn'(InitConfig));
	    addOneFontSize (#SymbolFn(FinalConfig)) (#SymbolFn'(InitConfig));

 	    TextIO.output(TextIO.stdOut, " done.\n")

	end
*)
	()

end

