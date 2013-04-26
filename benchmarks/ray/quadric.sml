(**************************************************************************)
(* Quadric Primitives for The Ghost CSG Raytracer - (C) Chris Walton 1994 *)
(**************************************************************************)
     
(* 
   Functions to calculate the intersection points and normals for a general
   quadric.   Written using the information from "Essential ray Tracing 
   Algorithms" by Eric Haines. (Chapter 2 - An Introduction to Ray Tracing)

   Quadric Equation : Ax^2 + 2Bxy + 2Cxz + 2D x + Ey^2 + 2Fyz + 2Gy + 
                      Hz^2 + 2Iz + J = 0
 
   Quadric primitive definition :  
 
   primtype = 4
   vecdata = []
   realdata = [A, B, C, D, E, F, G, H, I, J, 2*B, 2*C, 2*D, 2*F, 2*G, 2*I]
   intdata = []

*)

functor quadric (structure Csg : CSG) : PRIMITIVE =
  struct
    
    structure Csg=Csg
    open Csg
    open Csg.Ray
    open Csg.Ray.Vector

    fun intersect (Prim s, surf, Ray (O, RD)) =
	  let val (A,B,C,D,E,F,G,H,I,J,NB,NC,ND,NF,NG,NI) =
            case #realdata s of
              (A::B::C::D::E::F::G::H::I::J::NB::NC::ND::NF::NG::NI::_) =>
                (A,B,C,D,E,F,G,H,I,J,NB,NC,ND,NF,NG,NI)
            | _ => raise Match
              val (Xo, Yo, Zo) = (VecComp(O, 0), VecComp(O, 1), VecComp(O, 2))
              val (Xd, Yd, Zd) = (VecComp(RD, 0), VecComp(RD, 1), 
                                  VecComp(RD, 2))
              val Aq = Xd*(A*Xd+NB*Yd+NC*Zd)+Yd*(E*Yd+NF*Zd)+H*Zd*Zd
              val NBq = Xd*(A*Xo+B*Yo+C*Zo+D)+Yd*(B*Xo+E*Yo+F*Zo+G)+
                        Zd*(C*Xo+F*Yo+H*Zo+I)
              val Cq = Xo*(A*Xo+NB*Yo+NC*Zo+ND)+Yo*(E*Yo+NF*Zo+NG)+Zo*
                       (H*Zo+NI)+J
          in
            if Real.== (Aq,0.0) then (false, [])
            else 
              let val Ka = ~NBq/Aq
                  val Kb = Cq/Aq       
                  val disc = Ka*Ka-Kb
              in
                if disc<0.0 then (false, [])
                else 
                  let val disc2 = sqrt(disc)
                      val l1 = Ka+disc2
                  in
                    if l1<=epsilon then (false, [])
                    else
                      let val l0 = Ka-disc2
                      in
                        if l0>epsilon then 
                          (false, IsectAdd(IsectAdd([], l0, (Prim s, surf), 
                           true), l1, (Prim s, surf), false))
                        else 
                          (true, IsectAdd([], l1, (Prim s, surf), false))
                      end
                  end
              end
          end

    fun normal (Prim s, P) = 
          let val (A,B,C,D,E,F,G,H,I) =
            case #realdata s of
              (A::B::C::D::E::F::G::H::I::_) =>
                (A,B,C,D,E,F,G,H,I)
            | _ => raise Match
              val (Xi, Yi, Zi) = (VecComp(P, 0), VecComp(P, 1), VecComp(P, 2))
          in
            VecUnit(MakeVec(A*Xi+B*Yi+C*Zi+D, 
                            B*Xi+E*Yi+F*Zi+G, 
                            C*Xi+F*Yi+H*Zi+I))
          end

  end;
  










