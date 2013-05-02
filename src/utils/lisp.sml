(*  ==== UTILITIES : LISP ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  Some ideas from Common Lisp are given ML-like renderings here.
 *  (joint work by Brian & Matthew)
 * 
 *  - Unwind-protect is a way of ensuring that some `clean-up' code always
 *    gets done, even if an exception is raised by the body which would
 *    otherwise cause early termination.
 * 
 *  - Lisp like special variables allow for scoped updates to reference
 *    like objects.  Exiting their scope always _undoes_ the latest binding,
 *    even by exception exit.  In addition, they allow a type-safe form of
 *    _dynamic_ binding - which can (on occasion) do some useful things.
 *
 *    Since they are always initialised and scoped, you can never
 *    get out of sync due to exceptions being raised and then caught internally.
 *    A brief demo is given following the signature.
 * 
 *  Note that the primed versions of unwind_protect and letv are slightly more
 *  general versions that take an additional argument which initiates action 
 *  and is passed to the action functions. 
 *
 *  Revision Log
 *  ------------
 *  $Log: lisp.sml,v $
 *  Revision 1.4  1996/04/29 15:09:55  matthew
 *  Removing MLWorks.Integer
 *
 * Revision 1.3  1995/09/23  15:02:55  brianm
 * Adding unwind_protect' and letv' ...
 *
 *  Revision 1.2  1995/09/23  12:22:57  brianm
 *  Minor change to type of letv.
 *
 *  Revision 1.1  1995/09/22  14:22:51  brianm
 *  new unit
 *  New file.
 *
 *
 *)

signature LISP_UTILS =
   sig


     (* Unwind Protect :

           unwind_protect  body_fn coda_fn
           unwind_protect' body_fn coda_fn arg
      *)

     val unwind_protect  : (unit -> 'a) -> (unit -> 'b) -> 'a
     val unwind_protect' : ('a -> 'b) -> ('a -> 'c) -> ('a -> 'b)

     (* Note:  unwind_protect b_fn c_fn  =  unwind_protect' b_fn c_fn ()  *)

     (* Special Variables *)

     type 'a svref   (* Special Variable refs *)

     val svref : '_a -> '_a svref

     val letv  : ('_a svref * '_a) list -> (unit -> 'b) -> 'b
     val letv' : ('_a svref * '_a) list -> ('c -> 'b) -> 'c  -> 'b

     (* Note :  letv svl b_fn  =  letv' svl b_fn ()  *)

     val setv : '_a svref -> '_a -> unit

     val !! : '_a svref -> '_a

   end


 
(*  Here is a brief demo:

   fun print_int(i) =
       (
        output(std_out,Int.toString(i));
        output(std_out,"\n")
       )

   val my_sv1 = svref 23
   val my_sv2 = svref 42
   val my_sv3 = svref 27
  
   fun foo(sv) =
     ( setv sv (!!my_sv1 + !!my_sv2);
       print_int(!!sv)
     )

   exception MyException

   (letv [(my_sv1 , 2), (my_sv2 , 3)]
      (fn _ => (
          setv my_sv1 4;
	  foo (my_sv3);
	  (letv [(my_sv3, 6)]
	      (fn _ => (
		  setv my_sv2 (!!my_sv3);
		  foo (my_sv3)
	      ))
	  );
	  print_int (!!my_sv2);
	  raise MyException      
      ))
   ) handle _ => 0;
   
   !!my_sv1;
   !!my_sv2;
   !!my_sv3;

 *   Running the above gives the following results:
 * 
 *        val print_int : int -> unit = fn
 *        val my_sv1 : int svref = _
 *        val my_sv2 : int svref = _
 *        val my_sv3 : int svref = _
 *        val foo : int svref -> unit = fn
 *        exception MyException
 *        7                       -- first application of foo     
 *        10                      -- second application of foo    
 *        6                       -- from the explicit print_int  
 *        val it : int = 0        -- result of the outer letv, via the handle 
 * 
 *        val it : int = 23       -- current value of my_sv1 
 *        val it : int = 42       -- current value of my_sv2 
 *        val it : int = 7        -- current value of my_sv3 
 *)
