(* ==== Testing ====
 *
 * Result: OK
 *
 * $Log: char_vector.sml,v $
 * Revision 1.4  1998/02/18 11:56:01  mitchell
 * [Bug #30349]
 * Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.3  1997/11/21  10:43:39  daveb
 *  [Bug #30323]
 *
 *  Revision 1.2  1997/08/08  17:34:35  brucem
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *)


local

  val print = fn s => fn res => (print(s^":"^res^"\n"))

  fun check' s f = print s ((if f () then "OK" else "WRONG") handle exn => "FAIL:"^General.exnName exn)

  fun checkexn' s exn f = 
    let val result = (ignore(f ()); "FAIL") handle ex =>
      if General.exnName ex = General.exnName exn then 
        "OKEXN" 
      else 
        "BADEXN:" ^ (General.exnName ex)
    in
      print s result
    end

    (* Test map and mapi *)
    val add1 = fn c => chr (1 + ord c)
    val addi = fn (i, c) => chr (i + ord c)
    val s = "ABCDabcd"
    val test31 = check' "test31"
      (fn _ => (CharVector.map add1 s)="BCDEbcde")
    val test32 = check' "test32"
      (fn _ => (CharVector.map add1 "")="")
    val test33 = check' "test33"
      (fn _ => (CharVector.mapi addi (s, 0, NONE))="ACEGegik")
    val test34 = check' "test34"
      (fn _ => (CharVector.mapi addi (s, 1, NONE))="CEGegik")
    val test35 = check' "test35"
      (fn _ => (CharVector.mapi addi (s, 7, NONE))="k")
    val test36 = checkexn' "test36" Subscript
      (fn _ => (CharVector.mapi addi (s, ~1, NONE))) 
    val test37a = check' "test37a"
      (fn _ => (CharVector.mapi addi (s, 8, NONE)) = "")
    val test37b = checkexn' "test37b" Subscript
      (fn _ => (CharVector.mapi addi (s, 9, NONE)))
    val test38 = check' "test38"
      (fn _ => (CharVector.mapi addi (s, 0, SOME 2))="AC")
    val test39 = check' "test39"
      (fn _ => (CharVector.mapi addi (s, 6, SOME 2))="ik")
    val test40 = checkexn' "test40" Subscript
      (fn _ => (CharVector.mapi addi (s, 7, SOME 2)))
    val test41 = check' "test41"
      (fn _ => (CharVector.mapi addi (s, 2, SOME 0))="")
    val test42 = checkexn' "test42" Subscript
      (fn _ => (CharVector.mapi addi (s, 2, SOME (~1))))

in
  val it = () ;
end;
