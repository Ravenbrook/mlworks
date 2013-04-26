(*  ==== INITIAL BASIS : MONO ARRAY2 ====
 *
 *  Copyright (C) 1997 Harlequin Ltd.
 *  
 *  Implementation
 *  --------------
 *  The functor MonoArray2 is implemented generically using the code for Array2
 *
 *  This is part of the extended Initial Basis.
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: _mono_array2.sml,v $
 *  Revision 1.4  1999/03/20 21:27:54  daveb
 *  [Bug #20125]
 *  Replaced substructure with type.
 *
 *  Revision 1.3  1997/10/09  17:56:35  jkbrook
 *  [Bug #30245]
 *  Fix mistake in pattern: RowMajor should be Array2.RowMajor
 *
 *  Revision 1.2  1997/08/08  13:44:58  brucem
 *  [Bug #30245]
 *  Signature has changed.
 *
 *  Revision 1.1  1997/03/03  12:06:59  matthew
 *  new unit
 *
 *
 *)


require "_mono_array";
require "mono_array2";
require "__array";
require "__array2";
require "__list";
require "_mono_vector";

functor MonoArray2(type elem) : MONO_ARRAY2 =
  struct

    type elem = elem
    structure Array1 = MonoArray (type elem = elem)

    structure Vector = MonoVector(type elem = elem)

    type vector = Vector.vector

    (* We'll use these when we can *)
    (* For extra checks, define these to be the safe operations *)
    val usub = MLWorks.Internal.Value.unsafe_array_sub
    val uupdate = MLWorks.Internal.Value.unsafe_array_update

    datatype array = ARR2 of elem Array.array * int * int
    type region = {
      base : array,
      row : int, col : int,
      nrows : int option, ncols : int option}

    (* useful region of all the array *)
    fun allreg a = {base = a, row=0,col=0,nrows=NONE,ncols=NONE}

    datatype traversal = datatype Array2.traversal
    (* we are only bounded by the representation maximum *)
    val maxSize = Array.maxLen
    fun array (n,m,x) = ARR2 (Array.array (n*m,x),n,m)

    fun fromList [] = ARR2 (Array.fromList [],0,0)
      | fromList (l as (h::rest)) =
      let        
        val numcols = List.length h
        val numrows = List.length l
        (* Find the total length and check the lists are consistent lengths *)
        fun check ([],total) = total
          | check (l::rest,total) =
          let
            val len = List.length l
          in
            if len <> numcols
            then raise Size
            else check (rest,len + total)
          end
        (* utility function, append a list of lists *)
        fun appendl ([],[],acc) = rev acc
          | appendl ([],a::rest,acc) = appendl (a,rest,acc)
          | appendl (a::b,rest,acc) = appendl (b,rest,a::acc)
      in
        if check (rest,numcols) > maxSize
          then raise Size
        else ARR2 (Array.fromList (appendl ([],l,[])), numrows,numcols)
      end

    (* General function for checking if array sizes are allowable *)
    fun check_size (n,m) =
      if n < 0 orelse m < 0 orelse n * m > maxSize
        then true
      else false
      handle Overflow => true

    fun tabulate tr (n,m,f) =
        if check_size (n,m)
          then raise Size
        else
          case tr 
          of Array2.RowMajor => (* We just use Array.tabulate and some refs *)
            let
              val ir = ref 0
              val jr = ref 0
              fun tab _ = 
                let 
                  val i = !ir
                  val j = !jr
                  val result = f (i,j)
                  val j' = j + 1
                in
                  if j' = m then (ir := i+1;jr:=0)
                  else jr:=j';
                  result
                end
            in
              ARR2 (Array.tabulate (n * m, tab),
                    n,m)
            end
          | Array2.ColMajor =>(* Uses Array.array then Array.update to fill *) 
            let 
              val a = Array.array (n*m, f(0, 0))
              val ir = ref 1  val jr = ref 0 (* start down one row *)
              val _ =
                while (!jr < m) do (
                  Array.update (a, m * !ir + !jr, f(!ir, !jr));
                  ir := !ir + 1;
                  if(!ir = n) then (jr := !jr + 1; ir :=0) else ()
                )
            in
              ARR2(a, n, m)
            end
    (* end of fun tabulate *)


    (* sub and update *)
    fun sub (ARR2 (a,n,m),i,j) =
      if i < 0 then raise Subscript
      else if i >= n then raise Subscript
      else if j < 0 then raise Subscript
      else if j >= m then raise Subscript
      else usub (a,i*m+j)
    fun update (ARR2 (a,n,m),i,j,x) =
      if i < 0 then raise Subscript
      else if i >= n then raise Subscript
      else if j < 0 then raise Subscript
      else if j >= m then raise Subscript
      else uupdate (a,i*m+j,x)

    fun dimensions (ARR2 (a,n,m)) = (n,m)

    fun nCols (ARR2 (a,n,m)) = m
    fun nRows (ARR2 (a,n,m)) = n
    fun row (ARR2 (a,n,m),i) =
      if i < 0 then raise Subscript
      else if i >= n then raise Subscript
      else
        let
          val base = i * m
        in
          Vector.tabulate (n,fn j => usub (a,base+j))
        end

    (* use tabulate and a ref to avoid doing the multiply each time *)
    fun column (ARR2 (a,n,m),j) =
      if j < 0 then raise Subscript
      else if j >= m then raise Subscript
      else 
        let
          val ir = ref j
          fun tab _ =
            let
              val i = !ir
              val result = usub (a,i)
            in
              ir := i+m;
              result
            end
        in
          Vector.tabulate (m,tab)
        end

    (* Check that a slice is correctly ordered *)
    fun check (n,row,row') =
      0 <= row andalso row <= row' andalso row' <= n
        
    fun copy {src={base=ARR2(a,n,m),row,col,nrows,ncols},
              dst=ARR2(dst_a,dst_n,dst_m),
              dst_row,
              dst_col} =
      let
        val h = case nrows of SOME h => h | _ => n - row
        val w = case ncols of SOME w => w | _ => m - col
        val row' = row+h
        val col' = col+w
        val dst_row' = dst_row+h
        val dst_col' = dst_col+w
      in
        if not (check (n,row,row')) orelse
           not (check (m,col,col')) orelse
           not (check (dst_n,dst_row,dst_row')) orelse
           not (check (dst_m,dst_col,dst_col'))
          then raise Subscript
        else
          (* To ensure correct behaviour when copying from a to a *)
          (* we use different loop parameters for different cases *)
          let
            (* multiply through by num of columns here *)
            val (istart,iend,dst_istart,iinc,dst_iinc) =
              if dst_row <= row then (row*m,row'*m,dst_row*dst_m,m,dst_m)
              else ((row'-1)*m,(row-1)*m,(dst_row'-1)*dst_m,~m,~dst_m)
            fun loop1 (ibase,dst_ibase) =
              if ibase = iend then ()
              else
                let
                  val (jstart,jend,dst_jstart,jinc) =
                    if dst_col <= col then (col,col',dst_col,1)
                    else (col'-1,col-1,dst_col'-1,~1)
                  fun loop2 (j,dst_j) =
                    if j = jend then ()
                    else 
                      (uupdate (dst_a, dst_ibase + dst_j,
                                usub (a,ibase+j));
                       loop2 (j+jinc,dst_j+jinc))
                in
                  loop2 (jstart,dst_jstart);
                  loop1 (ibase+iinc,dst_ibase+dst_iinc)
                end
          in
            loop1 (istart,dst_istart)
          end
      end

    fun foldi traversal f acc {base=ARR2(a,n,m), row,col,nrows,ncols} =
      let
        val h = case nrows of SOME h => h | NONE => n - row
        val w = case ncols of SOME w => w | NONE => m - col
        val row' = row + h
        val col' = col + w
      in
        if not (check (n,row,row')) orelse not (check (m,col,col'))
          then raise Subscript 
        else
          case traversal of
            Array2.RowMajor =>
              let
                fun loop1 (i,ibase,acc) =
                  if i = row' then acc
                  else 
                    let 
                      fun loop2 (j,acc) =
                        if j = col' then acc
                        else loop2 (j+1,f (i,j,usub (a,ibase+j),acc))
                    in
                      loop1 (i+1,ibase+m,loop2 (col,acc))
                    end
              in
                loop1 (row,row*m,acc)
              end
          | Array2.ColMajor =>
              let
                val base = row*m
                fun loop1 (j,acc) =
                  if j = col' then acc
                  else 
                    let 
                      (* index strides through the column elements *)
                      (* incrementing by m each time *)
                      fun loop2 (i,index,acc) =
                        if i = row' then acc
                        else loop2 (i+1,index+m,f (i,j,usub (a,index),acc))
                    in
                      loop1 (j+1,loop2 (row,base+j,acc))
                    end
              in
                loop1 (col,acc)
              end
      end

    fun fold tr f init arr =
      foldi tr (fn (_,_,a,b) => f (a,b)) init (allreg arr)

    fun modifyi tr f (r as {base = a, ...}) =
      foldi tr (fn (i,j,x,_) => update (a,i,j,f (i,j,x))) () r

    fun modify tr f a = 
      modifyi tr (f o #3) (allreg a)

    fun appi tr f r =
      foldi tr (fn (i,j,x,_) => f (i,j,x)) () r

    fun app tr f a = 
      appi tr (f o #3) {base = a, row=0,col=0,nrows=NONE,ncols=NONE}

  end


