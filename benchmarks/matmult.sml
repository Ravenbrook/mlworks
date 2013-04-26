(* 2-d matrix multiply *)
use "utils/fastlude";

local
exception Shape
val dim = 200

  fun dot (i,j,A : int array2,B : int array2) =
      let val (ar,ac) = length2 A
	  val (br,bc) = length2 B
      in if ac<>br then raise Shape
         else let fun dot(k,sum) = 
                if k<ac then
                  let val sum'=sum + sub2(A,i,k) * sub2(B,k,j)
                  in dot(k+1,sum')
                  end
                else sum
              in dot(0,0)
              end
      end

   fun pr (A : int array2) =
       let val (ar,ac) = length2 A
           fun f(i) =
	        if i<ar then
		    let fun g(j) =
			if j<ac then (print(makestring_int(sub2(A,i,j)));
				      print " "; g(j+1))
			else (print "\n"; f(i+1))
		    in g 0
		    end
               else ()
      in f 0
      end

in
  fun mult (A : int array2, B : int array2) =
      let val (ar,ac) = length2 A
          val (br,bc) = length2 B
      in if ac<>br then raise Shape
         else
	    let val c = array2(ar,bc,0)
                fun f(i) =
                  if i<ar then
                    let fun g(j) =
	                if j<bc then (update2(c,i,j,dot(i,j,A,B));
				      g(j+1))
                        else ()
                    in (g 0; f(i+1))
                    end
                  else ()
            in f 0; c
            end
      end

val a = array2(dim,dim,1)
fun doit () = mult(a,a)
(*
val _ = pr b
*)
end


use "utils/benchmark";

test "matmult" 1 doit ();
