(* $Log: fastlude.sml,v $
 * Revision 1.4  1998/03/26 15:33:23  jont
 * [Bug #30090]
 * Remove use of MLWorks.IO
 *
 *  Revision 1.3  1998/02/20  09:02:14  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.2  1998/02/19  18:30:32  jont
 *  [Bug #30364]
 *  Remove use of loadSource, no longer necessary
 *
 *  Revision 1.1  1997/01/07  13:38:28  matthew
 *  new unit
 * *)

  (* fast version of TIl prelude *)

  (* list ops *)

  fun rev l =
	let fun f (nil, h) = h
	      | f (a::r, h) = f(r, a::h)
	in  f(l,nil)
	end
  fun nil @ M = M
    | (x :: L) @ M = x :: (L @ M)
  fun map f =
      let fun m nil = nil
	    | m (a::r) = f a :: m r
      in  m
      end
  fun length l = 
      let fun j(k,nil) = k
	    | j(k, a::x) = j(k+1,x)
      in j(0,l)
      end
  exception NthTail
  exception Hd (* = List.Empty *)
  exception Tl (* = List.Empty *)
  exception Nth = Subscript

  fun hd (a::r) = a | hd nil = raise Hd
  fun tl (a::r) = r | tl nil = raise Tl    
  fun null nil = true | null _ = false
  fun fold f [] = (fn b => b)
    | fold f (a::r) = (fn b => let fun f2(e,[]) = f(e,b)
				     | f2(e,a::r) = f(e,f2(a,r))
			       in f2(a,r)
			       end)
  fun revfold f [] = (fn b => b)
    | revfold f (a::r) = (fn b => let fun f2(e,[],b) = f(e,b)
					| f2(e,a::r,b) = f2(a,r,f(e,b))
				  in f2(a,r,b)
				  end)	
  fun app f =
      let fun loop [] = ()
	    | loop (hd::tl) = (ignore(f hd); loop tl)
      in
	 loop
      end
  fun revapp f = let fun a2 (e::r) = (a2 r; ignore(f e); ()) | a2 nil = () in a2 end
  fun nthtail(e,0) = e 
    | nthtail(e::r,n) = nthtail(r,n-1)
    | nthtail _ = raise NthTail
  fun nth x = hd(nthtail x) handle NthTail => raise Nth | Hd => raise Nth
  fun exists pred =
      let fun f nil = false
	    | f (hd::tl) = pred hd orelse f tl
      in  f
      end

    
    type 'a array1 = 'a Array.array

    fun unsafe_array1(s : int, e : '_a) : '_a array1 =  Array.array(s,e)

    val length1 = Array.length

    fun unsafe_sub1(a : '_a array1, index : int) : '_a = 
	  MLWorks.Internal.Value.unsafe_array_sub (a,index)

    fun unsafe_update1(a : '_a array1, index : int, e : '_a) : unit = 
	  MLWorks.Internal.Value.unsafe_array_update (a,index,e)

    fun array1 (s:int, e : '_a) =
	if s<0 then raise Size
	else unsafe_array1(s,e)
  
    fun sub1 (a : '_a array1, index :int) =
	if index<0 orelse index>=length1 a then raise Subscript
	else unsafe_sub1(a,index)

    fun update1(a : '_a array1, index : int, e : '_a) : unit =
	if index<0 orelse index>=length1 a then raise Subscript
	else unsafe_update1(a,index,e)


    type '_a array2 = {rows : int,columns : int, v : '_a array1}

    fun array2(rows : int, columns : int, e : '_a) : '_a array2 = 
	if rows<0 orelse columns<0 then raise Size
	else {rows=rows,columns=columns,v=unsafe_array1(rows*columns,e)}

    (* column major order *)
(*
    fun sub2 ({rows,columns,v}, s :int, t:int) =
	if s <0 orelse s>=rows orelse t<0 orelse t>=columns then raise Subscript
	else unsafe_sub1(v,s*columns+t)
*)

    fun sub2 ({rows,columns,v}, s :int, t:int) =
	if s < 0 then raise Subscript
        else if s>=rows then raise Subscript
        else if t<0 then raise Subscript
        else if t>=columns then raise Subscript
	else unsafe_sub1(v,s*columns+t)

    fun update2 ({rows,columns,v}, s : int, t:int, e) : unit =
	if s<0 orelse s>=rows orelse t<0 orelse t>=columns then raise Subscript
	else unsafe_update1(v,s*columns+t,e)

    fun length2 ({rows,columns,v}) : int * int = (rows,columns)
    
    val makestring_int = Int.toString : int -> string
    val makestring_real = Real.toString : real -> string
    fun makestring_bool true = "true"
      | makestring_bool false = "false"
	
    fun inc r = r := !r + 1
    fun dec r = r := !r - 1
    (* misc *)
   fun min(a:int,b) = if a<b then a else b
   fun max(a:int,b) = if a>b then a else b

   val implode = implode

   val input_line = TextIO.inputLine

   val ordof = MLWorks.String.ordof
   val substring = MLWorks.String.substring

   exception Overflow

   infix 9 &&
   val op && = MLWorks.Internal.Bits.andb

  (* end of fast version of TIL prelude for MLWorks *)
