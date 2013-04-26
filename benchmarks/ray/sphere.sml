(************************************************************************)
(* Sphere Primitive for The Ghost CSG Raytracer - (C) Chris Walton 1994 *)
(************************************************************************)

(*
   Functions to calculate the intersection points and normals for a sphere. 
   Routine modified from the one given in the "Writing a Ray Tracer" paper by
   Paul S. Heckbert. (Chapter 7 - An Introduction to Ray Tracing)

   Sphere primitive definition : 

   primtype = 3 
   vecdata = [MakeVec(Centre)]
   realdata= [radius, radius^2]
   intdata=[]

*)

functor sphere (structure Csg : CSG) : PRIMITIVE =
  struct
    
    structure Csg=Csg
    open Csg
    open Ray
    open Vector
    
    fun intersect (Prim s, surf, Ray (O, D)) =
          let val V = VecSub ((hd(#vecdata s)), O)
              val b = VecDot (V, D)
              val disc = b*b-(VecDot (V, V))+(hd(tl(#realdata s)))
          in
            if disc<0.0 then (false, [])
            else
              let val disc2 = sqrt(disc)
                  val l1 = b+disc2
              in
                if l1<=epsilon then (false, [])
                else
                  let val l0 = b-disc2
                  in
                    if l0>epsilon then 
                      (false, IsectAdd(IsectAdd([], l0, (Prim s, surf), true),
                                      l1, (Prim s, surf), false))
                    else 
                      (true, IsectAdd([], l1, (Prim s, surf), false))
                  end
              end
          end

    fun normal (Prim s, P) = VecUnit(VecSub(P, hd(#vecdata s)))

    (* Inverse mapping function for a sphere. (CURRENTLY UNUSED) *)  
    local val twoPI = PI*2.0
          val PIdiv2 = PI/2.0    

          exception arc_sin
          fun arcsin x = if x == ~1.0 then ~PIdiv2
                         else if x == 1.0 then PIdiv2
                         else if x < ~1.0 orelse x > 1.0 then raise arc_sin
                         else atan(x/sqrt(1.0-x*x))
   
          exception arc_cos
          fun arccos x = PIdiv2-(arcsin x) handle arc_sin => raise arc_cos

    in fun point (Prim s, P, N) =
             let val (VP,E,C) =
               case #vecdata s of 
                 (_::VP::E::C::_) => (VP,E,C)
               | _ => raise Match
                 val r = hd (#realdata s)
                 val phi = arccos(VecDot((VecNeg N), VP))
                 val sphi = sin phi
                 val theta = if Real.== (sphi,0.0) then 0.0 
		             else arccos((VecDot(E, N))/sphi) 
                 val CdN = VecDot(C, N) 
                 val u = if CdN>0.0 then r*theta else r*(twoPI-theta)
             in
               (u, r*phi)
             end
    end 

  end;
