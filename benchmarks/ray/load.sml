open Math;

use "ray/build.sml";
fun go (f1,f2) =
  (print("Doing " ^ f1 ^ "\n");
   Main.go (f1,f2));

(*
go ("scenes/testcard.enff","scenes/testcard.ppm");
go ("scenes/balls.enff","scenes/balls.ppm");
go ("scenes/glass.enff","scenes/glass.ppm");
go ("scenes/quadrictest.enff","scenes/quadrictest.ppm");
go ("scenes/sps7.nff","scenes/sps7.ppm");

(* These ones are take rather a long time *)
go ("scenes/hangglider.nff","scenes/hangglider.ppm");
go ("scenes/house.nff","scenes/house.ppm");
*)

