(*****************************************************************************)
(*      "The Ghost" SML CSG Raytracer        (C) Chris Walton 26/5/94        *)
(*      Version 2.07                         (chrisw@epcc.ed.ac.uk)          *)
(*****************************************************************************)

(* val use = PolyML.use (required for Poly/ML) *)
 
use "ray/toolkit.sml";

use "ray/rayvector.sml";
use "ray/csg.sml";

use "ray/primsig.sml";
use "ray/planar.sml";
use "ray/sphere.sml";
use "ray/quadric.sml";
use "ray/cone.sml";
use "ray/primitives.sml";

use "ray/main.sml";

use "ray/ENFFIn.sml";
use "ray/PPMBinOut.sml";

(* Vector, Ray and Csg functions. *)
structure Csg = Csg(structure Ray=Ray(structure Vector=Vector));
    
(* The Main Ray-Tracing engine. *)
structure Main = 
  RayFunctions(structure Csg=Csg
               and AllPrimFns=AllPrimFns(structure Csg=Csg)
               and In=ENFFIn(structure Csg=Csg)
               and Out=PPMBinOut);






