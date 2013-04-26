(***************************************************************************)
(* Extended Neutral File Format Input for The Ghost CSG Raytracer (C) 1994 *)
(***************************************************************************)

(* Functions to read the raytracing data in from an ENFF file. 
   (ENFF is based upon the NFF created by Eric Haines - see documentation) 
   This functor was just bashed out quickly in an afternoon to test the
   raytracer and will hopefully be replaced by the usual Lex/Yacc combination 
   in future versions ... *)

fun ignore x = ()

functor ENFFIn (structure Csg : CSG) : IN =
  struct
 
    structure Csg=Csg
    open Csg
    open Ray
    open Vector
    open SML90

    datatype camera = Camera of {from       : vector,
				 lookat     : vector,
				 up         : vector,
                                 angles     : real * real,
                                 hither     : real, 
                                 resolution : int * int,
				 sky        : vector,
				 zenith     : real * real * real,
                                 horizon    : real * real * real,
				 ambience   : real * real * real,
                                 maxdepth   : int,
                                 minweight  : real}

    datatype light = Light of {pos     : vector,
			       col     : real * real * real,
                               noatten : bool,
                               atten   : real * real * real} 

    (* Function to skip white-space. (spaces, tabs and new-lines) *) 
    fun skip s = if lookahead s = " "  orelse
                    lookahead s = "\n" orelse
                    lookahead s = "\t" 
		 then (ignore(input (s, 1)); skip s)
                 else ()
    
    (* Skip the rest of a line. *)
    fun skipline s = if (lookahead s) = "\n" then input(s, 1)
                     else (ignore(input (s, 1)); skipline s)
	
    (* Test for the end of the file. *) 
    fun eof s = (skip s; end_of_stream s)
		    
    (* Test for digits and characters. *)
    fun digit c = (c >= "0" andalso c <= "9")
    fun char c = (c>="a" andalso c<="z") orelse (c>="A" andalso c<="Z")

    (* Is the next string a number ? *)
    fun number_next s = (skip s; (digit(lookahead s) orelse 
                                 (lookahead s)="-" orelse
                                 (lookahead s)="+"))

    (* Is the next string an entity ? *) 
    fun entity_next s = (skip s; char(lookahead s))

    (* Determine the numerical value of an ASCII character. *)
    exception Digitval
    fun digitval d = if digit d then ord d - ord "0"
                     else raise Digitval

    (* Functions to read an integer from a file. *)
    exception GetInt
    local fun getint' s n =
                if digit(lookahead s)
                then getint' s (10 * n + digitval(input(s, 1)))
                else n
          fun getposint s = if digit(lookahead s)
                            then getint' s 0
                            else raise GetInt
    in fun getint s =
             (skip s; if lookahead s = "-"
		        then (ignore(input(s, 1)); ~(getposint s))
                      else if lookahead s = "+"
                        then (ignore(input(s, 1)); (getposint s))  
                      else getposint s)
    end

    (* Functions to read a floating point number from a file. *)
    local fun getsign s =
               (skip s;
	       if (lookahead s) = "-" then (ignore(input (s, 1)); ~1.0)
               else if (lookahead s) = "+" then (ignore(input (s, 1)); 1.0)
               else 1.0)

          fun getwhole s n =
                if digit(lookahead s) then 
                getwhole s (10.0*n+(real(digitval(input(s, 1)))))
	        else n
      
          local fun getfractional' s n a =
                      if digit(lookahead s) then
		        getfractional' s (n*0.1) 
                          (a+n*(real(digitval(input(s, 1)))))
		      else a
          in fun getfractional s =
                   if (lookahead s) = "." then
	             (ignore(input (s, 1)); getfractional' s 0.1 0.0)
                   else 0.0
          end
  
          fun getexponent s =
                if (lookahead s) = "e" orelse (lookahead s) = "E" then
	          (ignore(input(s, 1)); real(getint s) handle GetInt => 0.0)
                else 0.0

    in fun getreal s =
           let val sign = getsign s
               val whole = getwhole s 0.0
               val frac = getfractional s
               val ex = getexponent s
           in 
             sign*((whole+frac)*(pow 10.0 ex))
           end  
    end
        
    (* Functions to read a word (character string) from a file. *)             
    local fun getchars s t = 
                if char(lookahead s) 
                then getchars s (t^(input(s, 1)))
                else t
    in fun getstring s = (skip s; getchars s "")
    end

    (* Compute the axes for polygons. *)
    fun get_axes N =
          let val x = abs (VecComp(N, 0)) 
              val y = abs (VecComp(N, 1)) 
              val z = abs (VecComp(N, 2)) 
          in
            if x>y andalso x>z then (1, 2)
            else if y>x andalso y>z then (0, 2)
            else (0, 1)
          end

    (* Read a plane primitive. *) 
    fun read_plane s =
          let val a = getreal s
              val b = getreal s
              val c = getreal s
              val d = getreal s
              val N = VecUnit(MakeVec(a, b, c))
              val (i0, i1) = get_axes N
          in
            Primitive(Prim ({primtype=0, vecdata=[N], realdata=[d], 
              intdata=[i0, i1]}))
          end

    (* Read a polygon primitive. *)
    local fun read_poly_data s (0, l) = rev l
            | read_poly_data s (n, l) =
                let val x = getreal s
                    val y = getreal s
                    val z = getreal s
                in
                  read_poly_data s (n-1, MakeVec(x, y, z)::l)
                end

          fun get_poly_details poly =
          let val (P0,P1,P2) = case poly of
            (P0::P1::P2::_) => (P0,P1,P2)
          | _ => raise Match
              val N = VecUnit(VecCross(VecSub(P0, P1), VecSub(P2, P1)))
              val d = ~(VecDot(N, P0))
          in (N, d) end

    in fun read_poly s =
            let val n = getint s
                val poly = read_poly_data s (n, [])
                val (N, d) = get_poly_details poly
                val (i0, i1) = get_axes N
            in
              Primitive(Prim ({primtype=1, vecdata=N::poly, realdata=[d], 
                intdata=[i0, i1]}))
            end 
    end

    (* Read a polygon patch primitive. *)
    local fun read_patch_data s (0, l) = l
            | read_patch_data s (n, l) =
                let val vx = getreal s
                    val vy = getreal s
                    val vz = getreal s
                    val nx = getreal s
                    val ny = getreal s
                    val nz = getreal s
                in 
                  read_patch_data s (n-1, l@
                    [MakeVec(vx, vy, vz), VecUnit(MakeVec(nx, ny, nz))])
                end

          fun get_patch_details patch =
                let val (P0,P1,P2) =
                  case patch of (P0::_::P1::_::P2::_) => (P0,P1,P2)
                | _ => raise Match
                    val N = VecUnit(VecCross(VecSub(P0, P1), VecSub(P2, P1)))
                    val d = ~(VecDot(N, P0))
                in (N, d) end

    in fun read_poly_patch s =
             let val n = getint s
                 val patch = read_patch_data s (n, [])
                 val (N, d) = get_patch_details patch
                 val (i0, i1) = get_axes N
             in
               Primitive(Prim ({primtype=2, vecdata=N::patch, realdata=[d], 
                 intdata=[i0, i1]}))
             end
    end

    (* Read a sphere primitive. *)
    fun read_sphere s =
          let val x = getreal s
              val y = getreal s
              val z = getreal s
              val r = getreal s
          in
            Primitive(Prim ({primtype=3, vecdata=[MakeVec(x, y, z)],
	      realdata=[r, (r*r)], intdata=[]}))
          end

    (* Read a general quadric primitive. *)
    fun read_quadric s =
          let val a = getreal s
              val b = getreal s
              val c = getreal s
              val d = getreal s
              val e = getreal s
              val f = getreal s
              val g = getreal s
              val h = getreal s
              val i = getreal s
              val j = getreal s
          in
            Primitive(Prim ({primtype=4, vecdata=[], 
              realdata=[a, b, c, d, e, f, g, h, i, j, (b+b), (c+c), (d+d), 
              (f+f), (g+g), (i+i)], intdata=[]}))
          end

    fun read_cone s =
          let val bx = getreal s
              val by = getreal s
              val bz = getreal s
              val B = MakeVec(bx, by, bz)
              val br = getreal s
              val ax = getreal s
              val ay = getreal s
              val az = getreal s
              val A = MakeVec(ax, ay, az)
              val ar = getreal s
              val Wt = VecSub(A, B)
              val height = VecLen Wt
              val W = VecDiv(height, Wt)
              val slope = (ar-br)/height
              val based = ~(VecDot(B, W))
              val Tt = MakeVec(0.0, 0.0, 1.0)
              val T = if (1.0-abs(VecDot(Tt, W)))<epsilon then 
                        MakeVec(0.0, 1.0, 0.0)
                      else Tt
              val U = VecUnit(VecCross(W, T))
              val V = VecUnit(VecCross(U, W))
              val mindt = VecDot(W, B)
              val maxdt = VecDot(W, A)
              val (mind, maxd) = if maxdt<mindt then (maxdt, mindt) 
                                 else (mindt, maxdt) 
          in
            Primitive(Prim ({primtype=5, vecdata=[B, A, U, V, W], 
             realdata=[br, based, ar, height, slope, mind, maxd], intdata=[]}))
          end

    (* Function to read an object. (constructs CSG trees) *)
    fun read_object s obj =
          if obj="pl" orelse obj="plane" then 
            read_plane s
          else if obj="p" orelse obj="poly" orelse obj="polygon" then
            read_poly s
          else if obj="pp" orelse obj="patch" then  
            read_poly_patch s 
          else if obj="s" orelse obj="sphere" then  
            read_sphere s 
          else if obj="q" orelse obj="quadric" then 
            read_quadric s 
          else if obj="c" orelse obj="cone" then
            read_cone s
          else if obj="union" then 
            let val ol = read_object s (getstring s) 
                val or = read_object s (getstring s) 
	    in Composite(ol, Union, or) end
          else if obj="isect" orelse obj="inter" orelse obj="intersection" then
            let val ol = read_object s (getstring s) 
                val or = read_object s (getstring s) 
	    in Composite(ol, Inter, or) end
          else if obj="D" orelse obj="diff" orelse obj="difference" then 
           let val ol = read_object s (getstring s) 
                val or = read_object s (getstring s) 
	    in Composite(ol, Differ, or) end
	  else error (obj^" Not implemented")

    (* Read the viewing parameters. *)
    local fun read_camera s (Camera cam) =
                let val _ = getstring s         (* From *)
                    val fx = getreal s
                    val fy = getreal s
                    val fz = getreal s
                    val F = MakeVec(fx, fy, fz)
                    val _ = getstring s         (* At *)
		    val ax = getreal s
		    val ay = getreal s
		    val az = getreal s
		    val A = MakeVec(ax, ay, az) 
		    val _ = getstring s         (* Up *)
                    val ux = getreal s
                    val uy = getreal s
                    val uz = getreal s
                    val U = MakeVec(ux, uy, uz)
                    val _ = getstring s         (* Angles *)
		    val ax = getreal s
		    val ay = if (number_next s) then getreal s else ax 
		    val lx = (PI*ax)/360.0
		    val ly = (PI*ay)/360.0
		    val _ = getstring s         (* Hither *)
		    val h = getreal s
		    val _ = getstring s         (* Resolution *)
		    val rx = getint s
		    val ry = getint s
          in 
            Camera ({from=F, lookat=A, up=U, angles=(lx, ly), hither=h,  
                     resolution=(rx, ry), sky=MakeVec(ux, uy, uz), 
                     zenith=(#zenith cam), horizon=(#horizon cam), 
                     ambience=(#ambience cam), maxdepth=(#maxdepth cam),
	             minweight=(#minweight cam)})
          end

          (* Read a light source definition. *)
          fun read_light s =
                let val x = getreal s
                    val y = getreal s
		    val z = getreal s
		    val r = if (number_next s) then getreal s else 1.0
		    val g = if (number_next s) then getreal s else r
		    val b = if (number_next s) then getreal s else g
                in
                  Light {pos=MakeVec(x, y, z), col=(r, g, b), noatten=true,
		         atten=(0.0, 0.0, 1.0)}
                end

          (* Read the background (sky) colours. (horizon optional) *)
          fun read_bg s (Camera cam) =
                let val zr = getreal s
                    val zg = getreal s
		    val zb = getreal s
		    val hr = if (number_next s) then getreal s else zr
		    val hg = if (number_next s) then getreal s else zg
		    val hb = if (number_next s) then getreal s else zb
                in
                  Camera ({from=(#from cam), lookat=(#lookat cam), 
                    up=(#up cam), angles=(#angles cam), hither=(#hither cam), 
                    resolution=(#resolution cam), sky=(#sky cam), 
                    zenith=(zr, zg, zb), horizon=(hr, hg, hb),
                    ambience=(#ambience cam), maxdepth=(#maxdepth cam), 
                    minweight=(#minweight cam)})
                end

          (* Read the ambient intensities. *)
          fun read_ambient s (Camera cam) =
                let val i0 = getreal s
                    val i1 = getreal s
                    val i2 = getreal s
                in
                  Camera ({from=(#from cam), lookat=(#lookat cam), 
                    up=(#up cam), angles=(#angles cam), hither=(#hither cam), 
                    resolution=(#resolution cam), sky=(#sky cam), 
                    zenith=(#zenith cam), horizon=(#horizon cam),
                    ambience=(i0, i1, i2), maxdepth=(#maxdepth cam), 
                    minweight=(#minweight cam)})
               end

          (* Read the surface data in original NFF form. *)
          fun read_fill s (Surface fill) =
                let val r = getreal s
                    val g = getreal s
                    val b = getreal s
                    val Kd = getreal s
                    val Ks = getreal s
                    val Shine = getreal s
	            val T = getreal s
                    val ior = getreal s
                in
                  Surface ({noshadow=(#noshadow fill), metal=(#metal fill),
                    emitter=(#emitter fill), amb=(#amb fill), dif=Kd, 
                    dcol=(r, g, b), spec=Ks, sshn=Shine, stm=1.0, tns=T, 
                    tshn=Shine, ttm=0.9, ior=ior})
                end

          (* Read the surface data in new ENFF form. *)
          fun read_surface s (Surface fill) =
                let val r = getreal s
                    val g = getreal s
                    val b = getreal s
                    val Ka = getreal s
                    val Kd = getreal s
                    val Ks = getreal s
                    val SShine = getreal s
	            val Stm = getreal s
                    val Kt = getreal s
                    val TShine = getreal s
                    val Ttm = getreal s
                    val ior = getreal s
                in
                  Surface ({noshadow=(#noshadow fill), metal=(#metal fill),
                    emitter=(#emitter fill), amb=Ka, dif=Kd, dcol=(r, g, b), 
                    spec=Ks, sshn=SShine, stm=Stm, tns=Kt, tshn=TShine, 
                    ttm=Ttm, ior=ior})
                end

          fun shadow (Surface fill) v =
                Surface ({noshadow=v, emitter=(#emitter fill), 
	          metal=(#metal fill), amb=(#amb fill), dif=(#dif fill), 
                  dcol=(#dcol fill), spec=(#spec fill), sshn=(#sshn fill), 
                  stm=(#stm fill), tns=(#tns fill), tshn=(#tshn fill),
                  ttm=(#ttm fill), ior=(#ior fill)})

          fun emitter (Surface fill) v =
                Surface ({noshadow=(#noshadow fill), emitter=v, 
	          metal=(#metal fill), amb=(#amb fill), dif=(#dif fill), 
                  dcol=(#dcol fill), spec=(#spec fill), sshn=(#sshn fill), 
                  stm=(#stm fill), tns=(#tns fill), tshn=(#tshn fill),
                  ttm=(#ttm fill), ior=(#ior fill)})

          fun metal (Surface fill) v =
                Surface ({noshadow=(#noshadow fill), emitter=(#emitter fill), 
	          metal=v, amb=(#amb fill), dif=(#dif fill), 
                  dcol=(#dcol fill), spec=(#spec fill), sshn=(#sshn fill), 
                  stm=(#stm fill), tns=(#tns fill), tshn=(#tshn fill),
                  ttm=(#ttm fill), ior=(#ior fill)})

    in fun read_main s (cam, lights, fill, scene) =
           if (eof s) then (cam, lights, scene)
           else
             let val entity = getstring s
             in
               if entity="#" then 
                  (ignore(skipline s); read_main s (cam, lights, fill, scene))
	       else if entity="v" orelse entity="viewpoint" then  
                  read_main s (read_camera s cam, lights, fill, scene)
               else if entity="l" orelse entity="light" then 
                  read_main s (cam, (read_light s)::lights, fill, scene)
               else if entity="b" orelse entity="background" then
                  read_main s (read_bg s cam, lights, fill, scene)
               else if entity="ambience" orelse entity="ambient" then
                  read_main s (read_ambient s cam, lights, fill, scene)
               else if entity="f" orelse entity="fill" then
                  read_main s (cam, lights, read_fill s fill, scene)
               else if entity="surf" orelse entity="surface" then
                  read_main s (cam, lights, read_surface s fill, scene)
               else if entity="metal" orelse entity="metallic" then
                  read_main s (cam, lights, metal fill true, scene)
               else if entity="nometal" orelse entity="nonmetallic" then
                  read_main s (cam, lights, metal fill false, scene)
               else if entity="emitter" orelse entity="emmitter" then
                  read_main s (cam, lights, emitter fill true, scene)
               else if entity="noemmitter" orelse entity="noemmitter" then
                  read_main s (cam, lights, emitter fill false, scene)
               else if entity="shadow" then 
                  read_main s (cam, lights, shadow fill true, scene)
               else if entity="noshadow" then
                  read_main s (cam, lights, shadow fill false, scene)
               else 
                 let val Scene scn = scene
                 in
                   read_main s (cam, lights, fill, 
                     Scene (((read_object s entity), fill)::scn))
                 end
             end  
    end

    fun readata infilename =
	  let val infile = open_in infilename
              val defaultangle = (PI*45.0)/360.0
	      val defaultcam = Camera ({from=MakeVec(0.0, ~50.0, 0.0),
			         	lookat=MakeVec(0.0, 0.0, 0.0),
					up=MakeVec(0.0, 0.0, 1.0),
					angles=(defaultangle, defaultangle),
                                        hither=1.0,
					resolution=(200, 200),
					sky=MakeVec(0.0, 0.0, 1.0),
					zenith=(0.0, 0.0, 0.0),
                                        horizon=(0.0, 0.0, 0.0),
					ambience=(0.1, 0.1, 0.1),     
                                        maxdepth=8,
                                        minweight=0.01}) 
          in 
            read_main infile (defaultcam, [], air, (Scene [])) 
          end

  end;

