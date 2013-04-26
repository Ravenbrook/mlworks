(*****************************************************************************)
(* Ray and Vector Definitions for The Ghost CSG Raytracer - (C) Chris Walton *)
(*****************************************************************************)
    
signature VEC =
  sig
 
    (* Type representing a vector allowing equality testing. *)
    type vector

    (* Exceptions for vector division, normalising and components. *)
    exception vector_div and zero_vector and no_component

    (* Function to create a vector from 3 real components. *)
    val MakeVec  : real*real*real -> vector

    (* Function to return a particular component of a vector. *)
    val VecComp  : vector*int -> real

    (* Function to compute the dot-product of two vectors. (V1.V2) *)
    val VecDot   : vector*vector -> real

    (* Function to compute the cross-product of two vectors. (V1xV2) *) 
    val VecCross : vector*vector -> vector

    (* Function to compute the length (magnitude) of a vector. *) 
    val VecLen   : vector -> real

    (* Function to negate a vector. (i.e. reverse the direction) *)
    val VecNeg   : vector -> vector

    (* Function to add together two vectors. (V1+V2) *)
    val VecAdd   : vector*vector -> vector
  
    (* Function to subtract two vectors. (V1-V2) *)
    val VecSub   : vector*vector -> vector

    (* Function to scale the components of a vector by a real. *)
    val VecMult  : real*vector -> vector

    (* Function to divide the components of a vector by a real. *)
    val VecDiv   : real*vector -> vector

    (* Function to normalise a vector. (give it unit length) *)
    val VecUnit  : vector -> vector

    (* Function to perform a*V1+b*V2. *)
    val VecComb  : real*vector*real*vector -> vector
    
    (* Function to perform a*V1+V2. *)
    val VecAddS  : real*vector*vector -> vector

  end;

structure Vector : VEC =
  struct

    datatype vector = Vec of real * real * real

    fun MakeVec V = Vec V

    exception no_component 
    fun VecComp (Vec(x, y, z), c) =
	  case c of
 		    0 => x
		  | 1 => y
		  | 2 => z
                  | _ => raise no_component

    fun VecDot (Vec(x1, y1, z1), Vec(x2, y2, z2)) = (x1*x2+y1*y2+z1*z2)

    fun VecCross (Vec(x1, y1, z1), Vec(x2, y2, z2)) =
	  Vec(y1*z2-z1*y2, z1*x2-x1*z2, x1*y2-y1*x2)

    fun VecNeg (Vec(x, y, z)) = Vec(~x, ~y, ~z)

    fun VecAdd (Vec(x1, y1, z1), Vec(x2, y2, z2)) = Vec(x1+x2, y1+y2, z1+z2)

    fun VecSub (Vec(x1, y1, z1), Vec(x2, y2, z2)) = Vec(x1-x2, y1-y2, z1-z2)

    fun VecMult (a, Vec(x, y, z)) = Vec(a*x, a*y, a*z)

    exception vector_div
    fun VecDiv (a, Vec(x, y, z)) = if Real.== (a,0.0) then raise vector_div
                                   else Vec(x/a, y/a, z/a) 

    fun VecLen V = sqrt(VecDot(V, V))

    exception zero_vector
    fun VecUnit V = VecDiv(VecLen V, V) handle vector_div => raise zero_vector

    fun VecComb (a, V1, b, V2) = VecAdd(VecMult(a, V1), VecMult(b, V2))

    fun VecAddS (a, V1, V2) = VecAdd(VecMult(a, V1), V2)

  end;


signature RAY =
  sig
  
    structure Vector : VEC

    (* Datatype for a ray : first vector is the starting position of the ray,
                            second vector is the direction of the ray (unit).*)
    datatype ray = Ray of Vector.vector * Vector.vector

    (* Function to find the point at the real distance along the ray. *)
    val RayPoint        : ray*real -> Vector.vector

    (* Function to find the ray reflected of a surface.
       Arguments : Incident ray, Point of contact with surface,  
                   Surface normal vector. 
       Returns   : Reflected ray. *)
    val RayReflect      : ray*Vector.vector*Vector.vector -> ray

    (* Function to find the ray refracted through a surface (Heckbert's method)
       Arguments : Incident ray, Relative index of refraction (n2/n1),
                   Point of contact with surface, Surface normal vector. 
       Returns   : Total internal refraction? (True=tir), Refracted ray. *)
    val RayRefract      : ray*real*Vector.vector*Vector.vector -> bool*ray

  end;
  
functor Ray (structure Vector : VEC) : RAY =
  struct

    structure Vector = Vector
    open Vector

    datatype ray = Ray of vector * vector
  
    fun RayPoint (Ray(O, D), l) = VecAddS(l, D, O)

    fun RayReflect (Ray(_, I), P, N) =
          Ray(P, VecAddS(~2.0*VecDot(I, N), N, I))

    fun RayRefract ((R as Ray(_, I)), n, P, N) =
          let val eta = 1.0/n
              val c1 = ~(VecDot(I, N))
              val cs2 = 1.0-eta*eta*(1.0-c1*c1)
          in
            if (cs2<0.0) then (true, R)
            else (false, Ray(P, VecComb(eta, I, eta*c1-sqrt(cs2), N)))
          end

  end;




