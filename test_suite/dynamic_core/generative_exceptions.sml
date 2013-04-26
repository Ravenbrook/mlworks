(*

Result: OK

$Log : generative_exceptions.sml $

Copyright (c) 1994 Harlequin Ltd.
*) 

let
fun foo (acc,0) = let val exn = case rev acc of (exn::rest) => exn | _ => raise Div in raise exn end
  | foo (acc,n) =
    let
      exception Foo
    in
      foo (Foo :: acc,n-1) handle Foo => n
    end
in
  if foo ([],10) = 10 then () else print"Error\n"
end

