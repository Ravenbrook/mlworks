(*************************************************************************)
(* Planar Primitives for The Ghost CSG Raytracer - (C) Chris Walton 1994 *)
(*************************************************************************)

(* 
   Functions to calculate the intersection points and normals for planar
   primitives.   Polygon and Patch intersection routines modified from
   RayPolygon.c by Didier Badouel. (Graphics Gems I) 

   Plane Equation : Ax + By + Cz + D = 0

   Plane primitive definition :       
    
   primtype = 0
   vecdata = [MakeVec(A, B, C)]
   realdata = [D]
   intdata = []

   Polygon primitive definition :

   primtype = 1
   vecdata = [MakeVec(A, B, C), Point 1, Point 2, ...]
   realdata = [D]
   intdata = [axis1, axis2]  -  axes in polygon plane (0=X, 1=Y, 2=Z)

   Polygon Patch primitive definition :

   primtype = 2
   vecdata = [MakeVec(A, B, C), Point 1, Normal 1, Point 2, Normal 2, ...]
   realdata = [D]
   intdata = [axis1, axis2]  -  axes as above.

*)

functor planar (structure Csg : CSG) : PRIMITIVE =
  struct

    structure Csg = Csg
    open Csg
    open Ray
    open Vector

    local fun inside_poly _ _ [] = false
            | inside_poly (i0, i1, vx, vy, u0, v0) (u1, v1) (P::t) =
                let val u2 = VecComp(P, i0)-vx
                    val v2 = VecComp(P, i1)-vy
                    val inter = 
                          if Real.== (u1,0.0) then
                            let val beta=u0/u2
                            in 
                              if ((beta>=0.0) andalso (beta<=1.0) 
                              andalso not (Real.== (v1,0.0))) then 
                                let val alpha = (v0-beta*v2)/v1
                                in 
                                  ((alpha>=0.0) andalso ((alpha+beta)<=1.0))
                                end
                              else false
                            end
                          else 
                            let val t=(v2*u1-u2*v1)
                            in   
                              if not (Real.== (t,0.0)) then
                                let val beta=(v0*u1-u0*v1)/t
                                in 
                                  if ((beta>=0.0) andalso (beta<=1.0)) then 
                                    let val alpha = (u0-beta*u2)/u1
                                    in 
                                     ((alpha>=0.0) andalso ((alpha+beta)<=1.0))
                                    end
                                  else false
                                end
                              else false
                            end
                in 
                  if inter then true
                  else inside_poly (i0, i1, vx, vy, u0, v0) (u2, v2) t
                end
           
          fun inside_poly_patch (Prim s, _, _, _, _, _, _, _) _ [] = 
                (false, Prim s) 
            | inside_poly_patch (Prim s, i0, i1, vx, vy, u0, v0, N0) 
                 (u1, v1, N1) (P::N::t) =
                let val u2 = VecComp(P, i0)-vx
                    val v2 = VecComp(P, i1)-vy
                    val (alpha, beta, inter) = 
                          if Real.== (u1,0.0) then
                            let val b=u0/u2
                            in 
                              if ((b>=0.0) andalso (b<=1.0) andalso not (Real.== (v1,0.0)))
                              then 
                                let val a = (v0 - b*v2)/v1
                                in 
                                  (a, b, ((a>=0.0) andalso ((a+b)<=1.0)))
                                end
                              else (0.0, 0.0, false)
                            end
                          else 
                            let val t=(v2*u1-u2*v1) 
                            in
                              if not (Real.== (t,0.0)) then
                                let val b=(v0*u1-u0*v1)/t
                                in 
                                  if ((b>=0.0) andalso (b<=1.0)) then 
                                    let val a = (u0-b*u2)/u1
                                     in 
                                       (a, b, ((a>=0.0) andalso ((a+b)<=1.0)))
                                     end
                                  else (0.0, 0.0, false)
                                end 
                              else (0.0, 0.0, false)
                            end
                in 
                  if inter then 
                    let val gamma = 1.0 - (alpha+beta)
                        val NM = VecUnit(VecAdd(VecComb(gamma, N0, alpha, N1), 
                                   VecMult(beta, N)))
                        val newsolid = Prim {primtype=(#primtype s), 
                                             vecdata=NM::(tl (#vecdata s)), 
                                             realdata=(#realdata s),
                                             intdata=(#intdata s)}
                    in (true, newsolid) end
                  else inside_poly_patch (Prim s, i0, i1, vx, vy, u0, v0, N0) 
                                         (u2, v2, N) t
                end
            | inside_poly_patch _ _ _ = raise Match
          fun get_poly_data l = 
            (case l of 
               (_::V0::V1::R) => (V0,V1,R)
             | _ => raise Match)

          fun get_patch_data l = 
            (case l of 
               (_::V0::N0::V1::N1::R) => (V0, N0, V1, N1, R) 
             | _ => raise Match)

    in fun intersect (Prim s, surf, ray as Ray(O, D)) =
          let val N = hd (#vecdata s)
              val NdD = VecDot (N, D)
          in
            if Real.== (NdD,0.0) then (false, [])
            else
              let val l = ~(VecDot(N, O)+hd(#realdata s))/NdD
                  val inside = (NdD>0.0)
              in
                if l<=epsilon then (inside, [])
                else 
                  case (#primtype s) of

                  (* Infinite plane *)
                    0 => if inside then 
                           (true, IsectAdd([], l, (Prim s, surf), false))
                         else 
                           (false, IsectAdd([], l, (Prim s, surf), true))

                  (* Polygon *)
                  | 1 => let val (i0,i1) = 
                           case #intdata s of 
                             (i0::i1::_) => (i0,i1) 
                           | _ => raise Match
                             val (V0, V1, R) = get_poly_data (#vecdata s)
                             val vx = VecComp (V0, i0)
                             val vy = VecComp (V0, i1)
                             val P = RayPoint (ray, l)
                             val inpoly = inside_poly (i0, i1, 
                                  vx, vy, VecComp(P, i0)-vx, VecComp(P, i1)-vy)
                                  (VecComp(V1, i0)-vx, VecComp(V1, i1)-vy) R
                         in 
                           if inpoly then 
                             (if inside then 
                               (true, IsectAdd([], l, (Prim s, surf), false))
                             else 
                               (false, IsectAdd([], l, (Prim s, surf), true)))
                           else (inside, [])
                         end

                  (* Polygon patch *) 
                  | 2 => let val (i0,i1) = 
                         case #intdata s of 
                           (i0::i1::_) => (i0,i1) |
                             _ => raise Match
                             val (V0, N0, V1, N1, R) = 
                                   get_patch_data (#vecdata s)
                             val vx = VecComp (V0, i0)
                             val vy = VecComp (V0, i1)
                             val P = RayPoint (ray, l)
                             val (inpoly, prm) = inside_poly_patch (Prim s, 
                                 i0, i1, vx, vy,
                                 VecComp(P, i0)-vx, VecComp(P, i1)-vy, N0) 
                                 (VecComp(V1, i0)-vx, VecComp(V1, i1)-vy, N1) R
                         in 
                           if inpoly then 
                             if inside then 
                               (true, IsectAdd([], l, (prm, surf), false))
                             else 
                               (false, IsectAdd([], l, (prm, surf), true))
                           else (inside, [])
                         end 
                  | _ => raise Match
              end
          end
    end

    fun normal (Prim s, _) = hd (#vecdata s)
 
  end;









