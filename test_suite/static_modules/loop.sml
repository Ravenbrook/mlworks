(*
This tests for a bug in circular unification testing.

Result: FAIL
 
$Log: loop.sml,v $
Revision 1.1  1993/06/04 09:51:59  matthew
Initial revision


Copyright (c) 1993 Harlequin Ltd.
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
