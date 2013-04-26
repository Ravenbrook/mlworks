(*  ==== Testing ====
 *
    Result: OK
 *
 *  Copyright (C) 1997 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: real_array2.sml,v $
 *  Revision 1.5  1998/04/21 12:19:47  mitchell
 *  [Bug #30336]
 *  Fix tests to agree with change in spec of toString and fmt
 *
 *  Revision 1.4  1998/02/18  11:56:01  mitchell
 *  [Bug #30349]
 *  Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.3  1997/11/21  10:47:57  daveb
 *  [Bug #30323]
 *
 *  Revision 1.2  1997/08/08  15:59:14  brucem
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *)

  fun maken (n,m) =
    RealArray2.tabulate RealArray2.RowMajor
      (n,m,fn (i,j) => Real.fromInt(i*m+j))

  fun allreg a = {base = a, row = 0, col = 0, nrows = NONE, ncols = NONE}

  fun mkreg (a, r, c, h, w) =
                {base = a, row = r, col = c, nrows = SOME h, ncols = SOME w}

  fun iprint a =
    let
      fun pad s = if size s < 3 then pad (" " ^ s) else s
        
      fun one (i,j,n) =
        print ((if j = 0 then "\n" else "") ^ pad (Real.toString n) ^ " ")
    in
      RealArray2.appi RealArray2.RowMajor one (allreg a);
      print "\n"
    end;

  val _ = 
    let
      val i = ref (~1)
      val a = RealArray2.tabulate RealArray2.RowMajor
                 (4, 6, (fn _ => (i:= !i+1; Real.fromInt (!i))))
      val b = RealArray2.tabulate RealArray2.RowMajor 
                 (4, 6, (fn (a,_) => (Real.fromInt a)))
      val c = RealArray2.tabulate RealArray2.ColMajor 
                 (4, 6, (fn (_,a) => (Real.fromInt a)))
    in
      print "tabulate RowMajor\n";
      iprint a ; iprint b ; iprint c
    end

  val _ = 
    let
      val i = ref (~1)
      val a = RealArray2.tabulate RealArray2.ColMajor 
                 (4, 6, (fn _ => (i:= !i+1; Real.fromInt (!i))))
      val b = RealArray2.tabulate RealArray2.ColMajor 
                 (4, 6, (fn (a,_) => (Real.fromInt a)))
      val c = RealArray2.tabulate RealArray2.ColMajor 
                 (4, 6, (fn (_,a) => (Real.fromInt a)))
    in
      print "tabulate ColMajor \n";
      iprint a ; iprint b ; iprint c
    end
  

  fun copytest (a,b,c,d,e,f) =
    let val arr = maken (6,8)
    in
      RealArray2.copy {src=mkreg (arr, a,b,c,d), dst=arr, dst_row=e, dst_col=f};
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
      val dst = RealArray2.array (10,10,0.0)
    in
      RealArray2.copy {src=mkreg (arr, a,b,c,d), dst_row=e, dst_col = f, dst=dst};
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
    (RealArray2.app RealArray2.RowMajor (fn x => print (Real.toString x ^ " "))
       (maken (4,6));
     print "\n") ;

  val _ = 
    (RealArray2.app RealArray2.ColMajor (fn x => print (Real.toString x ^ " "))
       (maken (4,6));
     print "\n") ;

  val _ = 
    (RealArray2.appi RealArray2.RowMajor 
       (fn (i,j,x) => if i <> j then () else print (Real.toString x ^ " "))
       (allreg (maken (4, 6)));
      print "\n") ;

  val _ = 
    (RealArray2.appi RealArray2.ColMajor 
       (fn (i,j,x) => if i <> j then () else print (Real.toString x ^ " "))
       (allreg (maken (4, 6)));
      print "\n") ;

  val _ = (RealArray2.appi RealArray2.RowMajor
            (fn (i,j,x) => if i = j then () else print (Real.toString x ^ " "))
            {base = maken(4, 6), row=1,col=1, nrows=SOME 3, ncols=SOME 3};
           print "\n") ;

  val _ = (RealArray2.appi RealArray2.ColMajor
            (fn (i,j,x) => if i = j then () else print (Real.toString x ^ " "))
            {base = maken(4, 6), row=1,col=1, nrows=SOME 3, ncols=SOME 3};
           print "\n") ;


  print "modify test\n";
  val _ = 
    let
      val a = maken (4,6)
    in
      RealArray2.modifyi RealArray2.RowMajor 
        (fn (i,j,x) => if i = j then 0.0 else x + x) (allreg a);
      iprint a
    end;

  val _ = 
    let
      val a = maken (4,6)
    in
      RealArray2.modifyi RealArray2.RowMajor 
        (fn (i,j,x) => if i = j then 0.0 else x + x) (mkreg(a, 1,1,3,4));
      iprint a
    end;

  val _ = 
    let 
      val a = RealArray2.array (4, 6, 0.0)
      val i = ref (~1)
      fun m _ = (i:=(!i+1); Real.fromInt (!i))
    in
      print "modify RowMajor\n";
      RealArray2.modify RealArray2.RowMajor m a;
      iprint a
    end ;

  val _ = 
    let 
      val a = RealArray2.array (4, 6, 0.0)
      val i = ref (~1)
      fun m _ = (i:=(!i+1); Real.fromInt (!i))
    in
      print "modify ColMajor\n";
      RealArray2.modify RealArray2.ColMajor m a;
      iprint a
    end ;


  val _ = print "fold test\n";
  val fold1 = rev (RealArray2.fold RealArray2.RowMajor op:: [] (maken (4,4)));
  val fold2 = rev (RealArray2.fold RealArray2.ColMajor op:: [] (maken (4,4)));
  val fold3 = (ignore(rev (RealArray2.foldi RealArray2.RowMajor (fn _ => raise Div) []
               (mkreg (maken(4, 4), ~1,1,2,2)))); "FAIL")
               handle Subscript => "OK";
  val fold4 = (ignore(rev (RealArray2.foldi RealArray2.RowMajor (fn _ => raise Div) []
               (mkreg (maken(4, 4), 100,1,2,2)))); "FAIL")
               handle Subscript => "OK";
  val fold5 = (ignore(rev (RealArray2.foldi RealArray2.RowMajor (fn _ => raise Div) []
               (mkreg (maken(4, 4), 1,1,200,2)))); "FAIL")
               handle Subscript => "OK";
  val fold6 = rev (RealArray2.fold RealArray2.ColMajor op:: [] (maken (4,4)));

