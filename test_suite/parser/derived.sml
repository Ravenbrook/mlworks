(*

A good test of derived forms.

Result: FAIL

This should give the answer 3.

If you consider the tables in appendix A as rewrite rules, then:

        if 1=2 then 3 else 4                    ==>
        case 1=2 of true => 3 | false => 4      ==>
        (fn true => 3 | false => 4)(1=2)

In this example, false has still identifier status c, but true has
identifier status v.  As a consequence, in the pattern
the type of true is guessed (rule 35)
and the type of false is looked up in the environment (rule 36).
This means that the expression is well-typed.

Copyright (c) 1993 Harlequin Ltd.
Supplied by Stefan Kahrs of the LFCS.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition, true);
signature s = sig type T; val true: T end;
structure ss:s = struct datatype T = true end;
local open ss
in
  val bad = if 1=2 then 3 else 4
end


