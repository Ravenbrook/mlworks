(*
 *
 * Result: OK
 *
 * $Log: match1.sml,v $
 * Revision 1.2  1997/11/21 10:52:42  daveb
 * [Bug #30323]
 *
 *  Revision 1.1  1997/04/14  13:34:14  jont
 *  new unit
 *  Test for bug 2048
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
 *)

datatype other = GLOBAL of int | SPECIAL of int | LOCAL

fun cmp(LOCAL, LOCAL) = EQUAL
  | cmp(LOCAL, _) = LESS
  | cmp(_, LOCAL) = GREATER
  | cmp(GLOBAL pid1, GLOBAL pid2) = Int.compare(pid1, pid2)
  | cmp(GLOBAL _, _) = GREATER
  | cmp(_, GLOBAL _) = LESS
  | cmp(SPECIAL s1, SPECIAL s2) = Int.compare(s1, s2)

fun cmp1(LOCAL,LOCAL) = EQUAL
  | cmp1(LOCAL,_) = LESS
  | cmp1(GLOBAL m,GLOBAL n) = Int.compare (m,n)
  | cmp1(GLOBAL _,_) = GREATER
  | cmp1(SPECIAL m, SPECIAL n) = Int.compare (m,n)
  | cmp1(SPECIAL _,LOCAL) = GREATER
  | cmp1(SPECIAL _,GLOBAL _) = LESS;
