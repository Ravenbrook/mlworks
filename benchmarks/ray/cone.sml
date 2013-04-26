(***************************************************************************)
(* Cone/Tube Primitive for The Ghost CSG Raytracer - (C) Chris Walton 1994 *)
(***************************************************************************)

(*
   Functions to calculate the intersection points and normals for a cone. 
   Routine modified directly from the MTV raytracer by Mark VandeWetterling

   Cone primitive definition :

   primtype = 5
   vecdata = [cone_base, cone_apex, cone_u, cone_v, cone_w]
   realdata = [baseradius, base_d, apexradius, height, slope, min_d, max_d]
   intdata = []

*)

functor cone (structure Csg : CSG) : PRIMITIVE =
  struct

    structure Csg = Csg
    open Csg
    open Ray
    open Vector
    
    fun conedata (Prim s) =
          let val (B,A,U,V,W) = 
            case #vecdata s of
              (B::A::U::V::W::_) => (B,A,U,V,W)
                | _ => raise Match
              val (br,bd,ar,height,slope,mind,maxd) =
                case #realdata s of
                  (br::bd::ar::height::slope::mind::maxd::_) =>
                    (br,bd,ar,height,slope,mind,maxd)
                | _ => raise Match
          in 
            (B, A, U, V, W, br, bd, ar, height, slope, mind, maxd) 
          end

    fun intersect (Prim s, surf, Ray (O, D)) =
          let val (B, A, U, V, W, br, bd, ar, height, slope, mind, maxd) = 
                conedata (Prim s)
              val VV = VecSub(O, B)
              val P0 = VecDot(VV, U)
              val P1 = VecDot(VV, V)
              val P2 = VecDot(VV, W)
              val D0 = VecDot(D, U)
              val D1 = VecDot(D, V)
              val D2 = VecDot(D, W)
              val a = D0*D0+D1*D1-slope*slope*D2*D2
              val b = 2.0*(P0*D0+P1*D1-slope*slope*P2*D2-br*slope*D2)
              val ct = slope*P2+br
              val c = P0*P0+P1*P1-(ct*ct) 
              val disc = b*b-4.0*a*c
          in
            if disc<0.0 then (false, [])
            else
              let val disc2 = sqrt(disc)
                  val l1 = ((~b)+disc2)/(a+a)
              in
                if l1<epsilon then (false, [])
                else 
                  let val l0=((~b)-disc2)/(a+a)
                      val nroots = if l0<epsilon then 1 else 2
                  in
                    if l0<epsilon then
                      let val d = VecDot(W, RayPoint(Ray(O, D), l1))
                      in 
                        if d>=mind andalso d<=maxd then 
                          (true, IsectAdd([], l1, (Prim s, surf), false))
                        else (false, [])
                      end
                    else
                      let val d0 = VecDot(W, RayPoint(Ray(O, D), l0))
                          val d1 = VecDot(W, RayPoint(Ray(O, D), l1))
                          val r0 = (d0>=mind andalso d0<=maxd)
                          val r1 = (d1>=mind andalso d1<=maxd)
                      in
                        if (r0 andalso r1) then 
                          (false, IsectAdd(IsectAdd([], l0, (Prim s, surf),
                          true), l1, (Prim s, surf), false))
                        else if r0 then
                          (false, IsectAdd([], l0, (Prim s, surf), true))
                        else if r1 then 
                          (true, IsectAdd([], l1, (Prim s, surf), false))
                        else (false, [])
                      end
                  end
              end
          end

    fun normal (Prim s, P) =
          let val (B, _, _, _, W, _, bd, _, _, slope, _, _) = conedata (Prim s)
              val t = ~(VecDot(P, W)+bd)
          in
            VecUnit(VecAddS((~ slope),W,VecUnit(VecSub(VecAddS(t, W, P), B)))) 
          end
  end
