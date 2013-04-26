(*
 *
 * $Log: common.ml,v $
 * Revision 1.2  1998/06/02 15:42:08  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
val RCSversion = ref "";
fun RCS version = RCSversion := (!RCSversion)^version^"\n";
RCS "$Id: common.ml,v 1.2 1998/06/02 15:42:08 jont Exp $";

(* A general purpose exception for things which I'm so sure can't    *)
(* happen that it isn't worth tracking them more precisely -- famous *)
(* last words... *)
exception Panic

(* Let's define a few more natural pervasives *)

fun fst (x,_) = x

fun snd (_,x) = x

fun forall p l = let fun fall [] = true
                       | fall (h::t) = (p h) andalso (fall t)
                  in fall l
                 end

fun flatten [] = []
  | flatten (h::t) = h@(flatten t)

fun filter p =
    let fun filt [] = []
          | filt (h::t) = let val ftail = filt t
                           in if p h then h::ftail else ftail
                          end
     in filt
    end

structure Lib =
struct

(* stuff for handling user interrupts in SML/NJ (added by John Reppy) *)


   fun capturetopcont () = ()

(* MLA -- commented out *)
(*
       System.Unsafe.toplevelcont :=
          callcc (fn k => (callcc (fn k' => (throw k k'));
                           raise Interrupt))
*)


   exception AtoI
   fun atoi a =
       let fun digit "0" = 0  |  digit "1" = 1  |  digit "2" = 2
             | digit "3" = 3  |  digit "4" = 4  |  digit "5" = 5
             | digit "6" = 6  |  digit "7" = 7  |  digit "8" = 8
             | digit "9" = 9  |  digit _ = raise AtoI
           fun deal [] = 0
             | deal (h::t) = digit h + ((deal t) * 10)
        in deal(rev(explode a))
       end

   fun member eq (a,l) = exists (fn x => eq(x,a)) l

   fun rm eq (a,l) =
       let fun rma [] = []
             | rma (h::t) = if eq(h,a) then rma t else h::(rma t)
        in rma l
       end

   fun eq elt_eq =
       let fun equal ([],[]) = true
             | equal (a::s,b::t) = elt_eq(a,b) andalso equal(s,t)
             | equal _ = false
        in equal
       end

   fun le elt_le =
       let fun leq ([],_)        = true
             | leq (_,[])        = false
             | leq (h::t,h'::t') = elt_le(h,h') andalso
                                   (not (elt_le(h',h)) orelse leq(t,t'))
        in leq
       end

   fun del_dups eq =
       let fun dd m [] = m
             | dd m (h::t) = if member eq (h,m) then dd m t else dd (m@[h]) t
        in dd []
       end

   fun multiply prod l1 l2 =
       let fun mult [] l = []
             | mult (h::t) l =
               let fun m [] = []
                     | m (h'::t') = prod(h,h') :: (m t')
                in (m l)@(mult t l)
               end
        in mult l1 l2
       end

   fun mkstr mkstrelt sep []     = ""
     | mkstr mkstrelt sep [a]    = mkstrelt a
     | mkstr mkstrelt sep (h::t) = (mkstrelt h)^sep^(mkstr mkstrelt sep t)

   val ran = ref 123
   fun random ub = (ran := (1005 * !ran + 7473) mod 8192;
                    (!ran) div (8192 div ub + 1))

(* get_line ignores leading and trailing blanks,   *)
(* and allows for the continuation character "\".  *)

   fun get_line infile =
       let fun strip (" "::t) = strip t
             | strip ("\t"::t) = strip t
             | strip ("\n"::t) = strip t
             | strip l = l
           val revline = strip(rev(strip(explode(input_line infile))))
        in if not(null revline) andalso hd revline = "\\" then
              (implode(rev(strip(tl revline))))^" "^(get_line infile)
           else implode(rev revline)
       end

   fun startsWithCapital string = 
     (if (ord string) >= (ord "A") andalso
       (ord string) <= (ord "Z") then true
     else false) handle Ord => false

   fun startsWithTwoCapitals string =
     if startsWithCapital string
	andalso startsWithCapital (implode (tl (explode string))) then true
     else false
end;

(* This structure contains UI stuff which is independent of the	       *)
(* application. Really it should be rethought completely.  *)
structure UI =
  struct
    exception IO of string
    val debugon  = ref false

(* needed to flush output to std_out *)
   fun print (str,s) = (output(str,s); flush_out str)
   fun message s = print (std_out, ("\n"^s^"\n"))
   fun msg s = print (std_out, s)	(* no newlines *)
   fun error s = print (std_err, ("\n *** "^s^" *** \n"))
   fun debug s = (if !debugon then message ("DEBUG:"^s) else
		    ())

    val context = ref ""
    fun getcontext _ = (!context)
    fun setcontext s = (context := s)

    val date = "Mon Dec  5 16:56:31 GMT 1994"
    val version = "Edinburgh Concurrency Workbench, version 7.0beta, "

    fun banner false = message(version^"\n"^date)
      | banner true = message("Synchronous "^version^"\n"^date)

    fun cwb "debug" = (debugon := not(!debugon);
		       message ("Debugging? "^(bool_makestring(!debugon))))
      | cwb "version" = message (version^"\n"^date^"\n"^(!RCSversion))
      | cwb s = error (s^" is not a cwb option")
		     
    val breaks = ["(" , ")" , "[" , "]" , "{" , "}" ,
                     "+" , "|" , "\\", "/" , "=" , "." , "," , ":" , ";" ,
                     " " , "\t", "\n", "@" , "$" ]


    val instring : (string list ref) = ref []

    val infile   = ref std_in
    val outfile  = ref std_out
    (* pes: these now include the filenames, not just the streams. This *)
    (* seems to be for error reporting. *)
    val inflist  = ref ([] : (instream * string) list)
    val outflist = ref ([] : (outstream * string) list)

    fun is_std_in _ = null (!inflist)
    fun is_std_out _ = null (!outflist)
(*****************************************************************************)
(*       F U N C T I O N S   T H A T   D O   F I L E   H A N D L I N G       *)
(*****************************************************************************)

(*    fun error s = (message ("\n *** "^s^" *** \n"); *)
(*                      map (close_in o fst) (!inflist);    *)
(*                      inflist := []; *)
(*                      infile := std_in); *)

   fun newinfile fname = (infile := open_in fname;
                          inflist := ((!infile,fname)::(!inflist)))
                         handle Io _ => raise (IO "Input File Error")

   fun closeinfile eof_expected = 
       (if not eof_expected then 
            error
             ("Error: Unexpected End of File in "^(snd(hd(!inflist)))^".")
        else ();
        close_in(!infile);
        inflist := (tl(!inflist));
        if is_std_in() then ((*message "done.";*) infile := std_in)
        else infile := fst(hd(!inflist)))


(*    fun newinfile fname = (infile := open_in fname; *)
(*                           inflist := (!infile)::(!inflist))) *)
(*                          handle Io _ => raise (IO "Input File Error") *)


(* pes: this seems a tad drastic -- really advisable to kill so much? *)
(*    fun error s = (message ("\n *** "^s^" *** \n"); *)
(*                      map (close_in o fst) (!inflist);    *)
(*                      map (close_out o fst) (!outflist); *)
(*                      inflist := [];           outflist := []; *)
(*                      infile := std_in;        outfile := std_out) *)


    fun fatalerror s = (error s;
		    if not (is_std_in()) then
		      (app (close_in o fst) (!inflist);   
		      inflist := [];       
		      infile := std_in;
		      (* do let's tell the user what's going on... *)
		      error
		      (" Resetting input stream to take input from stdin"))
		    else ())


(*    fun closeinfile _ = (close_in(fst(!infile)); *)
(*                         inflist := (tl(!inflist)); *)
(*                         if is_std_in() then infile := std_in *)
(*                         else infile := (snd(hd(!inflist)))) *)

   fun closeoutfile _ = (close_out(!outfile);
                         outflist := (tl(!outflist));
                         if is_std_out() then outfile := std_out
                         else outfile := fst(hd(!outflist)))

   fun canceloutfile _ =
       if (is_std_out()) then raise (IO "No Output file opened")
       else closeoutfile();

   fun newoutfile fname = (outfile := open_out fname;
                           outflist := ((!outfile, fname)::(!outflist));
			   message ("Outfile is now "^fname))
                          handle Io _ => raise (IO "Output File Error")
(*****************************************************************************)
(*        R E A D I N G   F R O M   I N T E R A C T I V E   I N P U T        *)
(*****************************************************************************)

   fun readin (eof_expected,noblank) prompt =
       let val s = explode(if is_std_in() then
                                (msg prompt; Lib.get_line(!infile))
                           else if end_of_stream(!infile) then
                                (closeinfile(eof_expected); 
                                 if eof_expected then "" else "\n")    (* NB *)
                           else Lib.get_line(!infile))
        in if (null s andalso noblank) orelse
              (not(null s) andalso hd s = "*") then
                readin (eof_expected,noblank) prompt
           else (instring := s)
       end

   fun nextcomm acc [] = (readin (false,false) ""; 
                          nextcomm (" "::acc) (!instring))
     | nextcomm acc ("*"::t) = (readin (false,false) "";
                          nextcomm (" "::acc) (!instring))
     | nextcomm acc (";"::t) = (instring := []; implode(rev acc))
     | nextcomm acc ("\t"::t) = nextcomm (" "::acc) t
     | nextcomm acc ("\n"::_) = (instring := []; "")    (* NB unexpected EOF *)
     | nextcomm acc (ch::t) = nextcomm (ch::acc) t

   fun readcommand prompt = (readin (true,true) ("\n"^prompt^": "); 
                             nextcomm [] (!instring))

(* Historic *)

   fun strip [] = []
     | strip (h::t) = if h=" " orelse h="\t" then strip t else (h::t)

   fun nextword acc [] = (instring := []; implode(rev acc))
     | nextword acc (" "::t) = (instring := strip t; implode(rev acc))
     | nextword acc ("\t"::t) = (instring := strip t; implode(rev acc))
     | nextword acc (h::t) = nextword (h::acc) t

   fun readword prompt =
       (if null(!instring) then readin (true,true) prompt else ();
        nextword [] (!instring))

   fun readnewline prompt = (readin (true,true) prompt; nextword [] (!instring))

   fun no_break breaks s = 
       not(exists (fn ch => exists (fn c => c = ch) breaks) s)


   fun readlist prompt =
       (if null(!instring) then readin (true,false) prompt else ();
        let fun rw [] [] = []
              | rw acc [] = [implode(rev acc)]
              | rw [] (" "::t) = rw [] t
              | rw [] ("\t"::t) = rw [] t
              | rw acc (" "::t) = (implode(rev acc))::(rw [] t)
              | rw acc ("\t"::t) = (implode(rev acc))::(rw [] t)
              | rw acc (","::t) = (implode(rev acc))::(rw [] t)
              | rw acc (c::t) = rw (c::acc) t
            val l = rw [] (!instring)
         in instring := []; l
        end)

   fun readline prompt =
       let val s = implode(!instring)
        in instring := [];
           if s <> "" then s
           else (if is_std_in() then message prompt else ();
                 Lib.get_line(!infile))
       end

   fun readnum prompt = (Lib.atoi(readword prompt))
                   handle Lib.AtoI =>
             if is_std_in() then (error("Error parsing Number");
                                readnum prompt)
             else raise (IO "Error parsing Number")
   fun readline prompt =
       let val s = implode(!instring)
        in instring := [];
           if s <> "" then s
           else (if is_std_in() then message prompt else ();
                 Lib.get_line(!infile))
       end


      

  end
