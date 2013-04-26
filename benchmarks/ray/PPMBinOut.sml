(****************************************************************************)
(* PPM Binary Picture Output for The Ghost CSG Raytracer - (C) Chris Walton *)
(****************************************************************************)

(* Functions to output the picture in binary Portable PixMap file format. *) 
structure PPMBinOut : OUT =
  struct
 	    
    open SML90

    local fun chr_clip v = if v<0 then 0
                           else if v>255 then 255
                           else v
    in fun writefn outfile max (_, _, (r, g, b, _)) =
            (output (outfile, chr (chr_clip (floor (max*r))));
             output (outfile, chr (chr_clip (floor (max*g))));
             output (outfile, chr (chr_clip (floor (max*b)))))
    end

    exception negative_int
    local fun convert 0 = ""
            | convert n = convert(n div 10) ^ chr(ord "0" + n mod 10)
    in fun putint s 0 = output(s, "0")
         | putint s n = if n<0 then raise negative_int
	                else output(s, convert n)
    end

    fun start (outfilename, (width, height)) =
          let val outfile = open_out outfilename
              val maxshade = 255   (* Maximum shades per colour *) 
          in
             (output(outfile, "P6\n");
	     (putint outfile width); output(outfile, " ");
	     (putint outfile height); output(outfile, "\n");
             (putint outfile maxshade); output(outfile, "\n");
             (outfile, (writefn outfile (real maxshade))))
          end
             
    fun finish outfile  = close_out outfile

 end;





