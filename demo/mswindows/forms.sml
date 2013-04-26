(*  ==== Needed for Life demo  ====
 *
 *  Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: forms.sml,v $
 * Revision 1.3  1997/06/16 12:36:46  jkbrook
 * [Bug #30127]
 * Merging changes from 1.0r2c1 into 2.0m0
 *
 *
 *  Revision 1.2  1996/11/07  16:49:08  jkbrook
 *  Needs to require String basis library
 *
 *  Revision 1.1  1996/10/11  14:14:22  johnh
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
