(***************************************************************************)
(* Primitive Functions for The Ghost CSG Raytracer - (C) Chris Walton 1994 *)
(***************************************************************************)

functor AllPrimFns (structure Csg : CSG) : ALLPRIMFNS =
  struct

    structure Csg = Csg
    open Csg

    structure plane = planar (structure Csg=Csg)
    structure sphere = sphere (structure Csg=Csg)
    structure quadric = quadric (structure Csg=Csg)
    structure cone = cone (structure Csg=Csg)

    val flist = [{intersect = plane.intersect,   (* 0 - Infinite Plane *) 
                  normal = plane.normal}, 
                 {intersect = plane.intersect,   (* 1 - Polygon *) 
                  normal = plane.normal}, 
                 {intersect = plane.intersect,   (* 2 - Polygon Patch *) 
                  normal = plane.normal}, 
                 {intersect = sphere.intersect,  (* 3 - Sphere *)
                  normal = sphere.normal},
                 {intersect = quadric.intersect, (* 4 - General Quadric *)
                  normal = quadric.normal},
                 {intersect = cone.intersect,    (* 5 - Cone / Tube *) 
                  normal = cone.normal}]    
  end;
  










