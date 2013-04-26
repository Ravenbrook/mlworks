(*  ==== Testing ====
 *
    Result: OK
 *
 *  Copyright (C) 1997 The Harlequin Group Ltd.  All rights reserved.
 *
 *  Revision Log
 *  ------------
 *  $Log: word32_array2.sml,v $
 *  Revision 1.4  1998/07/08 14:58:39  jont
 *  [Bug #70106]
 *  Avoid printing large word values, translate to large int
 *
 *  Revision 1.3  1998/02/18  11:56:02  mitchell
 *  [Bug #30349]
 *  Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.2  1997/11/26  19:00:56  daveb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *
*)

  fun maken (n,m) =
    Word32Array2.tabulate
      Word32Array2.RowMajor
      (n, m, fn (i,j) => Word32.fromInt (i*m+j))

  fun allreg a = {base = a, row = 0, col = 0, nrows = NONE, ncols = NONE}

  fun mkreg (a, r, c, h, w) =
                {base = a, row = r, col = c, nrows = SOME h, ncols = SOME w}

  fun iprint a =
    let
      fun pad s = if size s < 3 then pad (" " ^ s) else s
      fun one (i,j,n) =
        print ((if j = 0 then "\n" else "") ^ pad (Word32.toString n) ^ " ")
    in
      Word32Array2.appi Word32Array2.RowMajor one (allreg a);
      print "\n"
    end;

  val _ = 
    let
      val i = ref (0w0)
      val a = Word32Array2.tabulate Word32Array2.RowMajor
                 (4, 6, (fn _ => (!i before (i:= !i + 0w1))))
      val b = Word32Array2.tabulate Word32Array2.RowMajor 
                 (4, 6, (fn (a,_) => (Word32.fromInt a)))
      val c = Word32Array2.tabulate Word32Array2.ColMajor 
                 (4, 6, (fn (_,a) => (Word32.fromInt a)))
    in
      print "tabulate RowMajor\n";
      iprint a ; iprint b ; iprint c
    end

  val _ = 
    let
      val i = ref 0w0
      val a = Word32Array2.tabulate Word32Array2.ColMajor 
                 (4, 6, (fn _ => (!i before (i:= !i + 0w1))))
      val b = Word32Array2.tabulate Word32Array2.ColMajor 
                 (4, 6, (fn (a,_) => (Word32.fromInt a)))
      val c = Word32Array2.tabulate Word32Array2.ColMajor 
                 (4, 6, (fn (_,a) => (Word32.fromInt a)))
    in
      print "tabulate ColMajor \n";
      iprint a ; iprint b ; iprint c
    end
  

  fun copytest (a,b,c,d,e,f) =
    let val arr = maken (6,8)
    in
      Word32Array2.copy
	{src=mkreg (arr, a,b,c,d), dst=arr, dst_row=e, dst_col=f};
      iprint arr
    end;

  val _ = print "copy test\n";
  val _ = copytest (0,0,3,2,2,4);
  val _ = copytest (0,0,3,2,2,0);
  val _ = copytest (2,2,3,2,0,0);
  val _ = copytest (0,0,3,3,1,1);
  val _ = copytest (1,1,3,3,0,0);
  (copytest (0,0,2,1,2,~1) ; "FAIL") handle Subscript => "OK";
  (copytest (0,0,~2,1,2,1) ; "FAIL") handle Subscript => "OK";
  (copytest (0,0,2,~1,2,~1) ; "FAIL") handle Subscript => "OK";
  (copytest (0,10,2,1,2,~1) ; "FAIL") handle Subscript => "OK";

  fun copytest2 (a,b,c,d,e,f) =
    let 
      val arr = maken (6,8)
      val dst = Word32Array2.array (10,10,0w0)
    in
      Word32Array2.copy
	{src=mkreg (arr, a,b,c,d), dst_row=e, dst_col = f, dst=dst};
      iprint dst
    end;

  val _ = print "copy test2\n";
  val _ = copytest2 (0,0,3,2,2,4);
  val _ = copytest2 (0,0,3,2,2,0);
  val _ = copytest2 (2,2,3,2,0,0);
  val _ = copytest2 (0,0,3,3,1,1);
  val _ = copytest2 (1,1,3,3,0,0);
  (copytest2 (0,0,2,1,2,~1) ; "FAIL") handle Subscript => "OK";

  val _ = print "app test\n";
  val _ = 
    (Word32Array2.app
       Word32Array2.RowMajor
       (fn x => print (Word32.toString x ^ " "))
       (maken (4,6));
     print "\n") ;

  val _ = 
    (Word32Array2.app
       Word32Array2.ColMajor
       (fn x => print (Word32.toString x ^ " "))
       (maken (4,6));
     print "\n") ;

  val _ = 
    (Word32Array2.appi
       Word32Array2.RowMajor 
       (fn (i,j,x) => if i <> j then () else print (Word32.toString x ^ " "))
       (allreg (maken (4, 6)));
      print "\n") ;

  val _ = 
    (Word32Array2.appi
       Word32Array2.ColMajor 
       (fn (i,j,x) => if i <> j then () else print (Word32.toString x ^ " "))
       (allreg (maken (4, 6)));
      print "\n") ;

  val _ = (Word32Array2.appi
	    Word32Array2.RowMajor
            (fn (i,j,x) => if i = j then () else print (Word32.toString x ^ " "))
            {base = maken(4, 6), row=1,col=1, nrows=SOME 3, ncols=SOME 3};
           print "\n") ;

  val _ = (Word32Array2.appi
	    Word32Array2.ColMajor
            (fn (i,j,x) => if i = j then () else print (Word32.toString x ^ " "))
            {base = maken(4, 6), row=1,col=1, nrows=SOME 3, ncols=SOME 3};
           print "\n") ;


  print "modify test\n";
  val _ = 
    let
      val a = maken (4,6)
    in
      Word32Array2.modifyi
	Word32Array2.RowMajor 
        (fn (i,j,x) => if i = j then 0w0 else x + x) (allreg a);
      iprint a
    end;

  val _ = 
    let
      val a = maken (4,6)
    in
      Word32Array2.modifyi
	Word32Array2.RowMajor 
        (fn (i,j,x) => if i = j then 0w0 else x + x) (mkreg(a, 1,1,3,4));
      iprint a
    end;

  val _ = 
    let 
      val a = Word32Array2.array (4, 6, 0w0)
      val i = ref (0w0)
      fun m _ = (!i before (i:=(!i + 0w1)))
    in
      print "modify RowMajor\n";
      Word32Array2.modify Word32Array2.RowMajor m a;
      iprint a
    end ;

  val _ = 
    let 
      val a = Word32Array2.array (4, 6, 0w0)
      val i = ref (0w0)
      fun m _ = (!i before (i:=(!i + 0w1)))
    in
      print "modify ColMajor\n";
      Word32Array2.modify Word32Array2.ColMajor m a;
      iprint a
    end ;


  val _ = print "fold test\n";

  val fold1 =
    map LargeWord.toLargeInt
    (rev (Word32Array2.fold Word32Array2.RowMajor op:: [] (maken (4,4))));

  val fold2 =
    map LargeWord.toLargeInt
    (rev (Word32Array2.fold Word32Array2.ColMajor op:: [] (maken (4,4))));

  val fold3 =
    (ignore(rev
       (Word32Array2.foldi
	  Word32Array2.RowMajor
	  (fn _ => raise Div)
	  []
          (mkreg (maken(4, 4), ~1,1,2,2))));
     "FAIL")
    handle Subscript => "OK";

  val fold4 =
    (ignore(rev
       (Word32Array2.foldi
	  Word32Array2.RowMajor
	  (fn _ => raise Div)
	  []
          (mkreg (maken(4, 4), 100,1,2,2))));
     "FAIL")
    handle Subscript => "OK";

  val fold5 =
    (ignore(rev
       (Word32Array2.foldi
	  Word32Array2.RowMajor
	  (fn _ => raise Div)
	  []
          (mkreg (maken(4, 4), 1,1,200,2))));
     "FAIL")
     handle Subscript => "OK";

  val fold6 =
    map LargeWord.toLargeInt
    (rev (Word32Array2.fold Word32Array2.ColMajor op:: [] (maken (4,4))));

