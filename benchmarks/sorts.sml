(* $Log: sorts.sml,v $
 * Revision 1.2  1998/02/19 18:25:51  jont
 * [Bug #30364]
 * Remove use of loadSource, no longer necessary
 *
 *  Revision 1.1  1997/01/07  12:46:11  matthew
 *  new unit
 *  New unit
 * *)

(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)
 
use "utils/benchmark";

structure Sort =
  struct
    local
        fun bpart(test,a,n,m,p) =
          if n=m then n
          else
            let val next = Array.sub(a,m)
            in
              if test(next,p)
                then
                  (Array.update(a,n,next);
                   tpart(test,a,n+1,m,p))
              else
                bpart(test,a,n,m-1,p)
            end
        and tpart(test,a,n,m,p) =
          if n=m then n
          else
            let val next = Array.sub(a,n)
            in
              if test(next,p)
                then
                  tpart(test,a,n+1,m,p)
              else
                (Array.update(a,m,next);
                 bpart(test,a,n,m-1,p))
            end
        fun qaux(test,a,n,m) =
          if n = m
            then ()
          else
            let
              val p = Array.sub(a,n)
              val s = bpart(test,a,n,m-1,p)
            in
              Array.update(a,s,p);
              qaux(test,a,n,s);
              qaux(test,a,s+1,m)
            end

    fun qsort test a =
        qaux(test,a,0,Array.length a)

    fun array_to_list a =
      let fun aux 0 = []
        | aux n = Array.sub (a,n-1) :: aux (n-1)
      in
        rev (aux (Array.length a))
      end

(*
    fun mergesort test a =
      let
        fun maux(a1,a2,n,m) =
        if n = m then ()
        else
          if n = m-1 then Array.update(a2,n,Array.sub(a1,n))
        else
          let val split = (n + m) div 2
          in
            maux(a1,a2,n,split);
            maux(a1,a2,split,m);
            merge(a1,a2,n,split,m);
            copy(a2,a1,n,m)
          end
*)

      local
        val a = 16807.0
        val m = 2147483647.0
      in
        fun nextrand seed =
          let
            val t = a*seed
          in
            t - m * real(floor(t/m))
          end
      end

      fun myfloor x =
        floor x handle OverFlow => myfloor(x/2.0)

      fun randlist(n, seed, tail) =
        if n = 0 then tail
        else
          randlist(n-1, nextrand seed, (myfloor seed) :: tail)
        
      val sort_list = randlist(100000,1.0,[])

    in
      
    fun qsort_test () =
      let 
        val sort_array = Array.fromList sort_list
      in
        qsort (fn(a:int,b) => a < b) sort_array
      end
  end
end;

test "array quicksort" 1 Sort.qsort_test ()
