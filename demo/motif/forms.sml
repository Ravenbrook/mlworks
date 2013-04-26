(*  ==== Part of Life demo  ====
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
 * $Log: forms.sml,v $
 * Revision 1.3  1997/06/16 11:11:46  jkbrook
 * [Bug #30127]
 * Merging changes from 1.0r2c1 into 2.0m0
 *
 *
 *  Revision 1.2  1996/11/05  18:52:06  jkbrook
 *  Make file require basis library String
 *
 *  Revision 1.1  1996/10/11  14:01:20  johnh
 *  new unit
 *  Reorganised demo directory to include separate demos for mswindows and motif.
 *
 *
 *)

require "$.basis.__string";

fun conv sl =
  let
    fun scan1 (s,i,acc) =
      let
        val ss = size s
        fun aux (j,acc) =
          if j = ss then acc
          else 
            if String.substring (s,j,1) = "*"
              then aux (j+1,(j,i)::acc)
            else aux (j+1,acc)
      in
        aux (0,acc)
      end
    fun scan2 ([],i,acc) = rev acc
      | scan2 (s::rest,i,acc) =
        scan2 (rest,i+1,scan1 (s,i,acc))
  in
    scan2 (sl,0,[])
  end

val crash =
conv
["                                  *       ",
 "                                  * *     ",
 "*                     * *         **      ",
 "* *                   **                  ",
 "**      * *            *            ***   ",
 "        **                          *     ",
 "  ***    *             **            *    ",
 "  *                    * *   *            ",
 "   *     **            *    **            ",
 "         * *   *            * *           ",
 "         *    **    **                    ",
 "              * *   * *                   ",
 "                    *                     ",
 "                                       ** ",
 "                                       * *",
 "                                       *  ",
 "                                          ",
 "                                          ",
 "                            ***           ",
 "                            *             ",
 "                             *            "]


val small_spaceship =
conv
["**** ",
 "*   *",
 "*    ",
 " *   "]

val medium_spaceship=

conv
["***** ",
 "*    *",
 "*     ",
 " *    "]

val wide_ship =
conv
["        *       ",
 " ** *** ***     ",
 " **    *  ** ** ",
 "*  * **   *  ** ",
 "            *  *"]

val stuff = 
conv
[" ****        ",
 "*   *        ",
 "    *        ",
 "   *         ",
 "         ****",
 "        *   *",
 "            *",
 "    **  *  * ",
 "    ***      ",
 "    **  *  * ",
 "            *",
 "        *   *",
 "         ****",
 "   *         ",
 "    *        ",
 "*   *        ",
 " ****        "]

val rabbit =
conv
["*   ***",
 "***  * ",
 " *     "]

val big_glider =
conv
["    *  *          ",
"    *** *         ",
"   **             ",
"  * **   *        ",
"****   ** *       ",
" * *   ****       ",
" *       *        ",
"*   **    * **    ",
" *  **      * *   ",
"   * **         * ",
"    ** *     *  * ",
"               ** ",
"       **        *",
"       *  *    * *",
"        *       **",
"           * *    ",
"         ***  *   ",
"            ***   "]

val slow_ship =
conv
["                                 **      * * ",
"                 *               **     *** *",
"       **       ******           *     **    ",
"       *  *** *       **      *  *  *   *    ",
"      *          *  * **   *    *   *  *     ",
"     **** * *    *   ***   ** *** * *   *    ",
"     **      ***       ***      **   ***     ",
"    *                                  **    ",
" *** *                                       ",
"*  *                                         ",
" *** *                                       ",
"    *                                        ",
"     **      ***       ***      **           ",
"     **** * *    *   ***   ** *** *          ",
"      *          *  * **   *    *            ",
"       *  *** *       **      *  *           ",
"       **       ******           *           ",
"                 *               **          ",
"                                 **          "]
