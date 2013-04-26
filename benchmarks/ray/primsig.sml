(****************************************************************************)
(* Primitive signatures for The Ghost CSG Raytracer - (C) Chris Walton 1994 *)
(****************************************************************************)

signature PRIMITIVE =
  sig

    (* Requires the Csg structure defined in csg.sml. *)
    structure Csg : CSG
   
    (* General function to determine if a ray intersects a primitive. 
       Arguments : Primitive being tested, Surface type, Incoming ray.
       Returns   : Inside object (In=True), List of intersections. *) 
    val intersect : Csg.prim*Csg.surface*Csg.Ray.ray -> bool*(Csg.isect list)

    (* General function to find the surface normal at the Intersection point.
       Arguments : Primitive, Point of intersection.
       Returns   : Surface normal vector (unit) *) 
    val normal : Csg.prim*Csg.Ray.Vector.vector -> Csg.Ray.Vector.vector

  end;

signature ALLPRIMFNS =
  sig

    (* Requires the Csg structure defined in csg.sml. *)
    structure Csg : CSG

    (* Ordered list of functions for primitives. *)
    val flist :  {intersect : Csg.prim*Csg.surface*Csg.Ray.ray -> 
                                bool*(Csg.isect list),
                  normal    : Csg.prim*Csg.Ray.Vector.vector -> 
                                Csg.Ray.Vector.vector} list

  end;







