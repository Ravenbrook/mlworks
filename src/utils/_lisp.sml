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
 *  Revision Log
 *  ------------
 *  $Log: _lisp.sml,v $
 *  Revision 1.5  1998/02/19 19:41:35  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 * Revision 1.4  1995/09/25  13:01:47  brianm
 * Adding unwind_protect' and letv' ...
 *
 *  Revision 1.2  1995/09/23  12:24:32  brianm
 *  Minor change to type of letv.
 *
 *  Revision 1.1  1995/09/22  14:24:33  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "lisp";

functor LispUtils() : LISP_UTILS =
   struct

      fun unwind_protect (body_fn) (coda_fn) =
          let val res = body_fn ()
   	                handle exn => (ignore(coda_fn()); raise exn)
          in
              (* If we get here then body_fn succeeded *)
	      ignore(coda_fn());
	      res
          end

      fun unwind_protect' (body_fn) (coda_fn) (arg) =
          let val res = body_fn (arg)
   	                handle exn => (ignore(coda_fn(arg)); raise exn)
          in
              (* If we get here then body_fn succeeded *)
	      ignore(coda_fn(arg));
	      res
          end

      (* It is interesting to compare the code above with the following
         which looks similar and superficialy seems equivalent:

	 fun unwind_protect' (body_fn) (coda_fn) (arg) =
	     let val res = body_fn (arg)
	     in
		 (* If we get here then body_fn succeeded *)
		 coda_fn(arg);
		 res
	     end handle exn => (coda_fn(arg); raise exn)

         Of course the problem is - what happens if coda_fn
         raises an exception.  With this code, if the body_fn
         succeeded then the coda_fn gets invoked TWICE with
         argument arg, possibly causing repeated updates and
         side-effects - so this _isn't_ what we want!!
       *) 


      datatype ('a)svref = SV of 'a ref list ref

      fun svref (x) = SV (ref([ref x]))

      fun set_svref(SV(rl),x) = (rl := (ref x :: !rl))

      fun unset_svref(SV(rl),_) =
          case !rl of
            _ :: rest => rl := rest
          | _ => ()

      fun app f =
	let fun loop (a::rest) = (ignore(f(a)) ; loop(rest))
              | loop ([]) = ()
        in
            loop
        end

      fun letv (svref_l) (body_fn) =
  	  ( app set_svref svref_l;
	    unwind_protect body_fn (fn _ => app unset_svref svref_l)
          )

      fun letv' (svref_l) (body_fn) (arg) =
  	  ( app set_svref svref_l;
	    unwind_protect' body_fn (fn _ => app unset_svref svref_l) (arg)
          )

      exception UndefinedSpecialVariable

      fun setv (SV(ref(rx :: _))) (x) = (rx := x)
        | setv (_) (_)                = raise UndefinedSpecialVariable

      fun !! (SV(ref(ref(v) :: _))) = v
        | !! (_) = raise UndefinedSpecialVariable

      (* The exception UndefinedSpecialVariable cannot be raised in normal
         use - it is not possible to generate an empty svref, because of the
         robust way in which they are bound/unbound.
       *)

    end
