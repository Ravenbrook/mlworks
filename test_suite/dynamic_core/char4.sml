(*

Result: OK
 
$Log: char4.sml,v $
Revision 1.1  1995/08/10 14:56:02  jont
new unit


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

fun foo #"\000" = 0
  | foo #"\001" = 0
  | foo #"\002" = 0
  | foo #"\003" = 0
  | foo #"\004" = 0
  | foo #"\005" = 0
  | foo #"\006" = 0
  | foo #"\007" = 0
  | foo #"\008" = 0
  | foo #"\t" = 0
  | foo #"\n" = 0
  | foo #"\011" = 0
  | foo #"\012" = 0
  | foo #"\013" = 0
  | foo #"\014" = 0
  | foo #"\015" = 0
  | foo #"\016" = 0
  | foo #"\017" = 0
  | foo #"\018" = 0
  | foo #"\019" = 0
  | foo #"\020" = 0
  | foo #"\021" = 0
  | foo #"\022" = 0
  | foo #"\023" = 0
  | foo #"\024" = 0
  | foo #"\025" = 0
  | foo #"\026" = 0
  | foo #"\027" = 0
  | foo #"\028" = 0
  | foo #"\029" = 0
  | foo #"\030" = 0
  | foo #"\031" = 0
  | foo #" " = 0
  | foo #"!" = 0
  | foo #"\"" = 0
  | foo #"#" = 0
  | foo #"$" = 0
  | foo #"%" = 0
  | foo #"&" = 0
  | foo #"'" = 0
  | foo #"(" = 0
  | foo #")" = 0
  | foo #"*" = 0
  | foo #"+" = 0
  | foo #"," = 0
  | foo #"-" = 0
  | foo #"." = 0
  | foo #"/" = 0
  | foo #"0" = 0
  | foo #"1" = 0
  | foo #"2" = 0
  | foo #"3" = 0
  | foo #"4" = 0
  | foo #"5" = 0
  | foo #"6" = 0
  | foo #"7" = 0
  | foo #"8" = 0
  | foo #"9" = 0
  | foo #":" = 0
  | foo #";" = 0
  | foo #"<" = 0
  | foo #"=" = 0
  | foo #">" = 0
  | foo #"?" = 0
  | foo #"@" = 0
  | foo #"A" = 0
  | foo #"B" = 0
  | foo #"C" = 0
  | foo #"D" = 0
  | foo #"E" = 0
  | foo #"F" = 0
  | foo #"G" = 0
  | foo #"H" = 0
  | foo #"I" = 0
  | foo #"J" = 0
  | foo #"K" = 0
  | foo #"L" = 0
  | foo #"M" = 0
  | foo #"N" = 0
  | foo #"O" = 0
  | foo #"P" = 0
  | foo #"Q" = 0
  | foo #"R" = 0
  | foo #"S" = 0
  | foo #"T" = 0
  | foo #"U" = 0
  | foo #"V" = 0
  | foo #"W" = 0
  | foo #"X" = 0
  | foo #"Y" = 0
  | foo #"Z" = 0
  | foo #"[" = 0
  | foo #"\\" = 0
  | foo #"]" = 0
  | foo #"^" = 0
  | foo #"_" = 0
  | foo #"`" = 0
  | foo #"a" = 0
  | foo #"b" = 0
  | foo #"c" = 0
  | foo #"d" = 0
  | foo #"e" = 0
  | foo #"f" = 0
  | foo #"g" = 0
  | foo #"h" = 0
  | foo #"i" = 0
  | foo #"j" = 0
  | foo #"k" = 0
  | foo #"l" = 0
  | foo #"m" = 0
  | foo #"n" = 0
  | foo #"o" = 0
  | foo #"p" = 0
  | foo #"q" = 0
  | foo #"r" = 0
  | foo #"s" = 0
  | foo #"t" = 0
  | foo #"u" = 0
  | foo #"v" = 0
  | foo #"w" = 0
  | foo #"x" = 0
  | foo #"y" = 0
  | foo #"z" = 0
  | foo #"{" = 0
  | foo #"|" = 0
  | foo #"}" = 0
  | foo #"~" = 0
  | foo #"\127" = 0
  | foo #"\128" = 0
  | foo #"\129" = 0
  | foo #"\130" = 0
  | foo #"\131" = 0
  | foo #"\132" = 0
  | foo #"\133" = 0
  | foo #"\134" = 0
  | foo #"\135" = 0
  | foo #"\136" = 0
  | foo #"\137" = 0
  | foo #"\138" = 0
  | foo #"\139" = 0
  | foo #"\140" = 0
  | foo #"\141" = 0
  | foo #"\142" = 0
  | foo #"\143" = 0
  | foo #"\144" = 0
  | foo #"\145" = 0
  | foo #"\146" = 0
  | foo #"\147" = 0
  | foo #"\148" = 0
  | foo #"\149" = 0
  | foo #"\150" = 0
  | foo #"\151" = 0
  | foo #"\152" = 0
  | foo #"\153" = 0
  | foo #"\154" = 0
  | foo #"\155" = 0
  | foo #"\156" = 0
  | foo #"\157" = 0
  | foo #"\158" = 0
  | foo #"\159" = 0
  | foo #"\160" = 0
  | foo #"\161" = 0
  | foo #"\162" = 0
  | foo #"\163" = 0
  | foo #"\164" = 0
  | foo #"\165" = 0
  | foo #"\166" = 0
  | foo #"\167" = 0
  | foo #"\168" = 0
  | foo #"\169" = 0
  | foo #"\170" = 0
  | foo #"\171" = 0
  | foo #"\172" = 0
  | foo #"\173" = 0
  | foo #"\174" = 0
  | foo #"\175" = 0
  | foo #"\176" = 0
  | foo #"\177" = 0
  | foo #"\178" = 0
  | foo #"\179" = 0
  | foo #"\180" = 0
  | foo #"\181" = 0
  | foo #"\182" = 0
  | foo #"\183" = 0
  | foo #"\184" = 0
  | foo #"\185" = 0
  | foo #"\186" = 0
  | foo #"\187" = 0
  | foo #"\188" = 0
  | foo #"\189" = 0
  | foo #"\190" = 0
  | foo #"\191" = 0
  | foo #"\192" = 0
  | foo #"\193" = 0
  | foo #"\194" = 0
  | foo #"\195" = 0
  | foo #"\196" = 0
  | foo #"\197" = 0
  | foo #"\198" = 0
  | foo #"\199" = 0
  | foo #"\200" = 0
  | foo #"\201" = 0
  | foo #"\202" = 0
  | foo #"\203" = 0
  | foo #"\204" = 0
  | foo #"\205" = 0
  | foo #"\206" = 0
  | foo #"\207" = 0
  | foo #"\208" = 0
  | foo #"\209" = 0
  | foo #"\210" = 0
  | foo #"\211" = 0
  | foo #"\212" = 0
  | foo #"\213" = 0
  | foo #"\214" = 0
  | foo #"\215" = 0
  | foo #"\216" = 0
  | foo #"\217" = 0
  | foo #"\218" = 0
  | foo #"\219" = 0
  | foo #"\220" = 0
  | foo #"\221" = 0
  | foo #"\222" = 0
  | foo #"\223" = 0
  | foo #"\224" = 0
  | foo #"\225" = 0
  | foo #"\226" = 0
  | foo #"\227" = 0
  | foo #"\228" = 0
  | foo #"\229" = 0
  | foo #"\230" = 0
  | foo #"\231" = 0
  | foo #"\232" = 0
  | foo #"\233" = 0
  | foo #"\234" = 0
  | foo #"\235" = 0
  | foo #"\236" = 0
  | foo #"\237" = 0
  | foo #"\238" = 0
  | foo #"\239" = 0
  | foo #"\240" = 0
  | foo #"\241" = 0
  | foo #"\242" = 0
  | foo #"\243" = 0
  | foo #"\244" = 0
  | foo #"\245" = 0
  | foo #"\246" = 0
  | foo #"\247" = 0
  | foo #"\248" = 0
  | foo #"\249" = 0
  | foo #"\250" = 0
  | foo #"\251" = 0
  | foo #"\252" = 0
  | foo #"\253" = 0
  | foo #"\254" = 0
  | foo #"\255" = 1
