(*  ==== INITIAL BASIS : MATH ====
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
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: math.sml,v $
 *  Revision 1.3  1996/11/04 14:54:02  andreww
 *  [Bug #1711]
 *  real is no longer an equality type in sml'96.
 *
 *  Revision 1.2  1996/04/23  10:29:21  matthew
 *  Revisions
 *
 *  Revision 1.1  1996/04/23  10:19:57  matthew
 *  new unit
 *  Renamed from maths.sml
 *
 * Revision 1.1  1996/04/18  11:43:37  jont
 * new unit
 *
 *  Revision 1.2  1996/03/20  14:51:51  matthew
 *  Removing duplicated arctan2
 *
 *  Revision 1.1  1995/04/13  14:00:44  jont
 *  new unit
 *  No reason given
 *
 *
 *)

signature MATH =
  sig
    type real

    val pi : real
    val e : real

    val sqrt : real -> real
    val sin : real -> real
    val cos : real -> real
    val tan : real -> real
    val asin : real -> real
    val acos : real -> real
    val atan : real -> real
    val atan2 : real * real -> real
    val exp : real -> real
    val pow : real * real -> real
    val ln : real -> real
    val log10 : real -> real
    val sinh : real -> real
    val cosh : real -> real
    val tanh : real -> real

  end (* signature MATH *)
