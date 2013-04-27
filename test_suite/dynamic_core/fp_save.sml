(*
 *
 * Result: OK
 *
 * $Log: fp_save.sml,v $
 * Revision 1.9  1997/11/21 10:52:11  daveb
 * [Bug #30323]
 *
 * Revision 1.8  1997/05/28  12:07:21  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.7  1996/11/06  13:33:12  andreww
 * [Bug #1711]
 * real no longer equality type
 *
 * Revision 1.6  1996/11/06  12:00:48  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.5  1996/05/31  12:03:28  jont
 * Need to use the Math structure from the revised basis to get trig functions
 *
 * Revision 1.4  1996/05/22  10:54:48  daveb
 * Renamed Shell.Module to Shell.Build.
 *
 * Revision 1.3  1996/05/01  17:36:36  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.2  1995/07/04  16:48:01  jont
 * Revise to avoid trig inaccuracy problems
 *
 * Revision 1.1  1994/05/27  15:44:11  jont
 * new file
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


Shell.Options.set(Shell.Options.Language.oldDefinition,true);

fun length [] = 0
  | length (x::xs) = 1 + length xs;
    

val print = fn x => print(Int.toString x);

type float = real
type intg = int

(* -- MATH UTILITIES --------------------------------------------------------*)

val constant_pi        =  3.14159265358979323846
val constant_minus_pi  = ~3.14159265358979323846
val constant_pi2       =  1.57079632679489661923
val constant_minus_pi2 = ~1.57079632679489661923

fun
math_atan2 y x
  = if x > 0.0 then
      Math.atan ((y / x):real)
    else if x = 0.0 then
      if y < 0.0 then
        constant_minus_pi2
      else
        Math.atan (y / x) + constant_minus_pi
    else if x = 0.0 then
      constant_pi2
    else
      (Math.atan (y / x) + constant_pi)

(* -- POINTS ----------------------------------------------------------------*)

type pt = float * float * float

fun
pt_sub ((x1,y1,z1):pt) (x2,y2,z2)
  = (x1 - x2,y1 - y2,z1 - z2)

fun
pt_phi (x,y,z)
  = let
      val b = math_atan2 x z
    in
      math_atan2
        (((Math.cos b) * z + ((Math.sin b) * x))) y
    end

fun
pt_theta (x,y,z)
  =  math_atan2 x z

val tfo_id = (1.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0)

fun
tfo_apply (a,b,c,d,e,f,g,h,i,tx,ty,tz) (x:real,y:real,z:real)
  = (
      ((x * a) +
                  (y * d) +
                  (z * g) +
                  tx)
      ,
      ((x * b) +
                  (y * e) +
                  (z * h) +
                  ty)
      ,
      ((x * c) +
                  (y * f) +
                  (z * i) +
                  tz)
    )

(* The function "tfo-combine" multiplies two transformation matrices A and B.
|| The result is a new matrix which cumulates the transformations described
|| by A and B.
||
|| Note: in the measured program, this function was coded in assembler.
*)


local
  datatype nuc_specific =
    A of pt*pt*pt*pt*pt*pt*pt*pt
  | C of pt*pt*pt*pt*pt*pt
  | G of pt*pt*pt*pt*pt*pt*pt*pt*pt
  | U of pt*pt*pt*pt*pt

  val rC
    = (
      (    (~0.0359),  (~0.8071),   (0.5894),  (* dgf-base-tfo *)
           (~0.2669),   (0.5761),   (0.7726),
           (~0.9631),  (~0.1296),  (~0.2361),
            (0.1584),   (8.3434),   (0.5434)),
      (    (~0.8313),  (~0.4738),  (~0.2906),  (* P-O3'-275-tfo *)
            (0.0649),   (0.4366),  (~0.8973),
            (0.5521),  (~0.7648),  (~0.3322),
            (1.6833),   (6.8060),  (~7.0011)),
      (     (0.3445),  (~0.7630),   (0.5470),  (* P-O3'-180-tfo *)
           (~0.4628),  (~0.6450),  (~0.6082),
            (0.8168),  (~0.0436),  (~0.5753),
           (~6.8179),  (~3.9778),  (~5.9887)),
      (     (0.5855),   (0.7931),  (~0.1682),  (* P-O3'-60-tfo *)
            (0.8103),  (~0.5790),   (0.0906),
           (~0.0255),  (~0.1894),  (~0.9816),
            (6.1203),  (~7.1051),   (3.1984)),
      (    (2.6760),  (~8.4960),   (3.2880)), (* P    *)
      (    (1.4950),  (~7.6230),   (3.4770)), (* O1P  *)
      (    (2.9490),  (~9.4640),   (4.3740)), (* O2P  *)
      (    (3.9730),  (~7.5950),   (3.0340)), (* O5'  *)
      (    (5.2430),  (~8.2420),   (2.8260)), (* C5'  *)
      (    (5.1974),  (~8.8497),   (1.9223)), (* H5'  *)
      (    (5.5548),  (~8.7348),   (3.7469)), (* H5'' *)
      (    (6.3140),  (~7.2060),   (2.5510)), (* C4'  *)
      (    (7.2954),  (~7.6762),   (2.4898)), (* H4'  *)
      (    (6.0140),  (~6.5420),   (1.2890)), (* O4'  *)
      (    (6.4190),  (~5.1840),   (1.3620)), (* C1'  *)
      (    (7.1608),  (~5.0495),   (0.5747)), (* H1'  *)
      (    (7.0760),  (~4.9560),   (2.7270)), (* C2'  *)
      (    (6.7770),  (~3.9803),   (3.1099)), (* H2'' *)
      (    (8.4500),  (~5.1930),   (2.5810)), (* O2'  *)
      (    (8.8309),  (~4.8755),   (1.7590)), (* H2'  *)
      (    (6.4060),  (~6.0590),   (3.5580)), (* C3'  *)
      (    (5.4021),  (~5.7313),   (3.8281)), (* H3'  *)
      (    (7.1570),  (~6.4240),   (4.7070)), (* O3'  *)
      (    (5.2170),  (~4.3260),   (1.1690)), (* N1   *)
      (    (4.2960),  (~2.2560),   (0.6290)), (* N3   *)
      (    (5.4330),  (~3.0200),   (0.7990)), (* C2   *)
      (    (2.9930),  (~2.6780),   (0.7940)), (* C4   *)
      (    (2.8670),  (~4.0630),   (1.1830)), (* C5   *)
      (    (3.9570),  (~4.8300),   (1.3550)), (* C6 *)
      (C (
      (    (2.0187),  (~1.8047),   (0.5874)), (* N4   *)
      (    (6.5470),  (~2.5560),   (0.6290)), (* O2   *)
      (    (1.0684),  (~2.1236),   (0.7109)), (* H41  *)
      (    (2.2344),  (~0.8560),   (0.3162)), (* H42  *)
      (    (1.8797),  (~4.4972),   (1.3404)), (* H5   *)
      (    (3.8479),  (~5.8742),   (1.6480))) (* H6   *)
      )
    )

  fun
    nuc_C1'
    (dgf_base_tfo,p_o3'_275_tfo,p_o3'_180_tfo,p_o3'_60_tfo,
     p,o1p,o2p,o5',c5',h5',h5'',c4',h4',o4',c1',h1',c2',h2'',o2',h2',
     c3',h3',o3',n1,n3,c2,c4,c5,c6,_)
    = c1'

  fun
    nuc_C2 
    (dgf_base_tfo,p_o3'_275_tfo,p_o3'_180_tfo,p_o3'_60_tfo,
     p,o1p,o2p,o5',c5',h5',h5'',c4',h4',o4',c1',h1',c2',h2'',o2',h2',
     c3',h3',o3',n1,n3,c2,c4,c5,c6,_)
    = c2

  fun
    nuc_N1 
    (dgf_base_tfo,p_o3'_275_tfo,p_o3'_180_tfo,p_o3'_60_tfo,
     p,o1p,o2p,o5',c5',h5',h5'',c4',h4',o4',c1',h1',c2',h2'',o2',h2',
     c3',h3',o3',n1,n3,c2,c4,c5,c6,_)
    = n1

  fun hd (h::_) = h
    | hd _ = raise Match

  fun reference nuc i partial_inst = [ (i,tfo_id,nuc) ]

  fun get_var id ((i,t,n)::rest)
    = if id = i then (i,t,n) else get_var id rest
    | get_var _ _ = raise Match

  val h2 = hd(reference rC  27 [])

  val got_var as (i, t, n) = get_var 27 [h2]

  fun
    tfo_align (x1:real,y1:real,z1:real) (x2:real,y2:real,z2:real) (x3,y3,z3)
    = let
	val x31 = x3 - x1
	val y31 = y3 - y1
	val z31 = z3 - z1
	val rotpy = pt_sub (x2,y2,z2) (x1,y1,z1)
	val phi = pt_phi rotpy
	val theta = pt_theta rotpy
	val sinp = Math.sin phi
	val sint = Math.sin theta
	val cosp = Math.cos phi
	val cost = Math.cos theta
	val sinpsint = sinp * sint
	val sinpcost = sinp * cost
	val cospsint = cosp * sint
	val cospcost = cosp * cost
	val rotpz = (
		     ((cost * x31) -
		      (sint * z31))
		     ,
		     ((sinpsint * x31) +
		      (cosp * y31) +
		      (sinpcost * z31))
		     ,
		     ((cospsint * x31) +
		      (~ (sinp * y31)) +
		      (cospcost * z31))
		     )
	val rho = pt_theta rotpz
	val cosr = Math.cos rho
	val sinr = Math.sin rho
	val x = (~ (x1 * cost)) + (z1 * sint)
	val y = ((~ (x1 * sinpsint)) - (y1 * cosp)) -
	  (z1 * sinpcost)
	val z = ((~ (x1 * cospsint) + (y1 * sinp))) -
	  (z1 * cospcost)
      in
	(x31,
	 y31,
	 z31,
	 rotpy,
	 phi,
	 theta,
	 sinp,
	 sint,
	 cosp,
	 cost,
	 sinpsint,
	 sinpcost,
	 cospsint,
	 cospcost,
	 rotpz,
	 rho,
	 cosr,
	 sinr,
	 x,
	 y,
	 z,
	 ((cost * cosr) - (cospsint * sinr))
	 ,
	 sinpsint
	 ,
	 ((cost * sinr + (cospsint * cosr)))
	 ,
	 (sinp * sinr)
	 ,
	 cosp
	 ,
	 (~ (sinp * cosr))
	 ,
	 ((~ (sint * cosr)) - (cospcost * sinr))
	 ,
	 sinpcost
	 ,
	 ((~ (sint * sinr) + (cospcost * cosr)))
	 ,
	 ((x * cosr) - (z * sinr))
	 ,
	 y
	 ,
	 ((x * sinr + (z * cosr)))
	 )
      end
  val x =
    tfo_align (tfo_apply t (nuc_C1' n))
    (tfo_apply t (nuc_N1  n))
    (tfo_apply t (nuc_C2  n))
  val y =
    (~0.9859999999999998,
     2.164,
     ~0.5630000000000001,
     (~1.202,
      0.8580000000000005,
      ~0.1930000000000001),
     0.9568675027177516,
     4.553182164169473,
     0.8173910022700178,
     ~0.9873533414281583,
     0.5760832833957394,
     ~0.1585351039065183,
     ~0.8070537373446135,
     ~0.1295851674771304,
     ~0.568797754801688,
     ~0.09132942319195179,
     (~0.3995643187722262,
      2.115355659579794,
      ~1.156581077420785),
     3.474226348112135,
     ~0.9451856331291026,
     ~0.3265334882157378,
     ~0.3271384190492108,
     8.343388679242439,
     ~0.4618514933082989,
     ~0.03588641240560456,
     ~0.8070537373446135,
     0.5893864864778855,
     ~0.266905535207387,
     0.5760832833957394,
     0.7725862319946186,
     ~0.9630543082715082,
     ~0.1295851674771304,
     ~0.2360806719950002,
     0.1583965545822757,
     8.343388679242439,
     0.5433570452157466)
  fun sub3((x: real, y: real, z: real), (a, b, c)) =
    (x-a, y-b, z-c)
  fun sub((a1, b1, c1, d1, e1, f1, g1, h1, i1, j1, k1, l1, m1, n1, o1, p1, q1, r1, s1, t1, u1, v1, w1, x1, y1, z1, aa1, bb1, cc1, dd1, ee1, ff1, gg1),
	  (a2: real, b2: real, c2: real, d2: (real * real * real), e2: real, f2: real, g2: real, h2: real, i2: real, j2: real, k2: real, l2: real, m2: real, n2: real, o2: (real * real * real), p2: real, q2: real, r2: real, s2: real, t2: real, u2: real, v2: real, w2: real, x2: real, y2: real, z2: real, aa2: real, bb2: real, cc2: real, dd2: real, ee2: real, ff2: real, gg2: real)) =
    (a1 - a2, b1 - b2, c1 - c2, sub3(d1, d2), e1 - e2, f1 - f2, g1 - g2, h1 - h2, i1 - i2, j1 - j2, k1 - k2, l1 - l2, m1 - m2, n1 - n2, sub3(o1, o2), p1 - p2, q1 - q2, r1 - r2, s1 - s2, t1 - t2, u1 - u2, v1 - v2, w1 - w2, x1 - x2, y1 - y2, z1 - z2, aa1 - aa2, bb1 - bb2, cc1 - cc2, dd1 - dd2, ee1 - ee2, ff1 - ff2, gg1 - gg2)
  fun square3(a, b, c:real) = a*a + b*b + c*c
  fun sum_squares(a1: real, b1, c1, d1, e1, f1, g1, h1, i1, j1, k1, l1, m1, n1, o1, p1, q1, r1, s1, t1, u1, v1, w1, x1, y1, z1, aa1, bb1, cc1, dd1, ee1, ff1, gg1) =
    (a1*a1 + b1*b1 + c1*c1 + square3 d1 + e1*e1 + f1*f1 + g1*g1 + h1*h1 + i1*i1 + j1*j1 + k1*k1 + l1*l1 + m1*m1 + n1*n1 + square3 o1 + p1*p1 + q1*q1 + r1*r1 + s1*s1 + t1*t1 + u1*u1 + v1*v1 + w1*w1 + x1*x1 + y1*y1 + z1*z1 + aa1*aa1 + bb1*bb1 + cc1*cc1 + dd1*dd1 + ee1*ee1 + ff1*ff1 + gg1*gg1)
  val foo = sum_squares(sub(x, y))
in
  val result = foo < 1E~28
end
