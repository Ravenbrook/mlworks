(*
This tests for a bug in circular unification testing.

Result: FAIL
 
$Log: loop.sml,v $
Revision 1.1  1993/06/04 09:51:59  matthew
Initial revision


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

functor Foo (structure S : sig datatype t = T datatype 'a opt = ABSENT | PRESENT of 'a end) =
  struct 
    local val free_tyvars = ref []
    in
      datatype ('a,'b) Foo = SOME1 of 'a | SOME2 of  'b
      datatype valid = VAR of string | INT of int

      fun exists f [] = false
        | exists f (a::b) = f a orelse (exists f b)

      fun do_leaf((valid, ty as ref(ty',_)) :: tl) =
        let 
          infix ==
          fun tyv == S.ABSENT = 
            raise Div
            | tyv == (S.PRESENT(ref(tyv'))) = tyv = tyv'
          val lv = 
            case (raise Div) of
              SOME1(lv) => lv
            | SOME2(lvar as ref(lv,_)) => 
                (case valid of
                   VAR symbol => 
                     ((map (fn ref(_,_,_,tyvar,_) => 
                            if exists (fn (tyvar',_) => tyvar'==tyvar) 
                              (!free_tyvars) then ()
                            else 
                              free_tyvars := (tyvar,0) :: !free_tyvars)
                     [] (* (all_tyvars ty') *));
                     lvar := (lv,S.PRESENT ("",ty,free_tyvars));
                     lv)
                 | _ => lv)
        in
          do_leaf(tl)
        end

      val x = do_leaf ([(VAR "foo",ref(3,4))])
    end
  end
