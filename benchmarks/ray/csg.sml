(*********************************************************************)
(* CSG Functions for The Ghost CSG Raytracer - (C) Chris Walton 1994 *)
(*********************************************************************)

signature CSG =
  sig

    (* Requires the ray/vector structures defined in rayvector.sml. *)
    structure Ray : RAY

    (* Datatype representing a general primitive. *)
    datatype prim = Prim of {primtype : int,
                             vecdata  : Ray.Vector.vector list,
                             realdata : real list,
                             intdata  : int list}

    (* Datatype representing a surface:
         noshadow : The object casts no shadows ? 
         metal    : The object has a metallic appearance ?
         emitter  : The object has constant shading ?  
         amb      : The Ambient co-efficient. 
         dif      : The diffuse reflectance co-efficient. 
         dcol     : The diffuse colour of the object (r, g, b).
         spec     : The specular reflectance co-efficient. 
         sshn     : The specular reflection highlight co-efficient.
         stm      : The transmissivity per unit length of the medium for
                    a reflected ray.
         tns      : The specular transmissive co-efficient.
         tshn     : The specular transmission highlight co-efficient.
         ttm      : The transmissivity per unit length of the medium for
                    a transmitted ray.
         ior      : The index of refraction for the object. *)
    datatype surface = Surface of {noshadow : bool,           
                                   metal    : bool,           
				   emitter  : bool,
				   amb      : real,           
				   dif      : real,          
				   dcol     : real * real * real, 
				   spec     : real,      
				   sshn     : real,     
				   stm      : real,
				   tns      : real,           
				   tshn     : real,
				   ttm      : real,
				   ior      : real}           

    (* Datatype representing CSG operations. *)
    datatype CSGop = Inter | Union | Differ
    
    (* Datatype representing a CSG tree. *)
    datatype object = Composite of object * CSGop * object
                    | Primitive of prim

    (* Datatype representing the entire scene. *)
    datatype scene = Scene of (object*surface) list    

    (* Datatype representing an intersection. *)
    datatype isect = Isect of {l     : real,         (* Intersection distance*)
                               prim  : prim*surface, (* Object hit. *)
                               enter : bool}         (* Entering the object? *)

    (* Surface representing air. *)
    val air : surface 

    (* Function to add an intersection to a sorted list of intersections.
       Arguments : Sorted list of intersections, Distance along ray to 
                   intersection point, Primitive and surface, Entering?
       Returns   : Sorted list of intersection including new one. *)
    val IsectAdd : (isect list)*real*(prim*surface)*bool -> isect list

    (* Rules for combining CSG classifications.
       Arguments : CSG operation being performed, In left list?, 
                   In right list? (In=True)
       Returns   : Inside the CSG object? *)
    val CSGLookup : CSGop -> bool * bool -> bool

    (* Function to merge the left and right intersection lists under a CSG
       operation.
       Arguments : CSG operation, Inside left?, Left list, Inside right?, 
                   Right list, Inside object?, Intersections (empty on entry)
       Returns   : Sorted intersection list for CSG object. *)  
    val CSGMerge : CSGop -> bool*(isect list)*bool*(isect list)*bool*
                   (isect list) -> isect list

  end;
  
functor Csg (structure Ray : RAY) : CSG =
  struct
    
    structure Ray = Ray
    open Ray
    
    datatype prim = Prim of {primtype : int,
                             vecdata  : Vector.vector list, 
                             realdata : real list,
                             intdata  : int list}

    datatype surface = Surface of {noshadow : bool,
                                   metal    : bool,
                                   emitter  : bool,  
                                   amb      : real,
                                   dif      : real,
                                   dcol     : real * real * real,
                                   spec     : real,
                                   sshn     : real,
                                   stm      : real,
                                   tns      : real,
                                   tshn     : real,
                                   ttm      : real,
                                   ior      : real}
    
    datatype CSGop = Inter | Union | Differ
    
    datatype object = Composite of object * CSGop * object
                    | Primitive of prim 

    datatype scene = Scene of (object * surface) list    
    
    datatype isect = Isect of {l     : real,
                               prim  : prim * surface,
                               enter : bool}

    val air = Surface {noshadow=false, metal=false, emitter=false, amb=0.0, 
                       dif=0.0, dcol=(0.0, 0.0, 0.0), spec=0.0, sshn=0.0, 
                       stm=1.0, tns=1.0, tshn=0.0, ttm=1.0, ior=1.0}

    fun IsectAdd ([], l, prim, enter) = 
          [Isect {l=l, prim=prim, enter=enter}]
      | IsectAdd ((Isect h)::t, l, prim, enter) =
          if l<(#l h) then 
            (Isect {l=l, prim=prim, enter=enter})::(Isect h)::t 
          else (Isect h)::(IsectAdd(t, l, prim, enter))

    fun CSGLookup Union (true, true) = true
      | CSGLookup Union (true, false) = true
      | CSGLookup Union (false, true) = true
      | CSGLookup Union (false, false) = false
      | CSGLookup Inter (true, true) = true
      | CSGLookup Inter (true, false) = false
      | CSGLookup Inter (false, true) = false
      | CSGLookup Inter (false, false) = false
      | CSGLookup Differ (true, true) = false
      | CSGLookup Differ (true, false) = true
      | CSGLookup Differ (false, true) = false
      | CSGLookup Differ (false, false) = false
  
    fun CSGMerge csgop (_, [], _, [], i, l) = rev l
      | CSGMerge csgop (i1, ((Isect h1)::t1), i2, [], i, l) =
          let val next = #enter h1
          in
            if (CSGLookup csgop (next, i2))<>i then
              CSGMerge csgop (next, t1, i2, [], (not i), (Isect h1)::l)
            else CSGMerge csgop (next, t1, i2, [], i, l)
          end
      | CSGMerge csgop (i1, [], i2, ((Isect h2)::t2), i, l) =
          let val next = #enter h2
          in
            if (CSGLookup csgop (i1, next))<>i then
              (if csgop=Differ then 
                CSGMerge csgop (i1, [], next, t2, (not i), 
                  (Isect{l=(#l h2), prim=(#prim h2), enter=not(#enter h2)})::l)
              else CSGMerge csgop (i1, [], next, t2, (not i), (Isect h2)::l))
            else CSGMerge csgop (i1, [], next, t2, i, l)
          end
      | CSGMerge csgop (i1, ((Isect h1)::t1), i2, ((Isect h2)::t2), i, l) =
          if #l h1 <= #l h2 then 
            let val next = #enter h1
            in
              if (CSGLookup csgop (next, i2))<>i then
                CSGMerge csgop (next, t1, i2, ((Isect h2)::t2), (not i), 
                  (Isect h1)::l)
              else CSGMerge csgop (next, t1, i2, ((Isect h2)::t2), i, l)
            end
          else 
            let val next = #enter h2
            in
              if (CSGLookup csgop (i1, next))<>i then
                (if csgop=Differ then 
                CSGMerge csgop (i1, [], next, t2, (not i), 
                  (Isect{l=(#l h2), prim=(#prim h2), enter=not(#enter h2)})::l)
                else CSGMerge csgop (i1, [], next, t2, (not i), (Isect h2)::l))
              else CSGMerge csgop (i1, ((Isect h1)::t1), next, t2, i, l)
            end

  end;
 





