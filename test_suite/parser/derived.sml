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
Supplied by Stefan Kahrs of the LFCS.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition, true);
signature s = sig type T; val true: T end;
structure ss:s = struct datatype T = true end;
local open ss
in
  val bad = if 1=2 then 3 else 4
end


