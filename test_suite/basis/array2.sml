(*  ==== Testing ====
 *
    Result: OK
 *
 *  Copyright (C) 1997 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: array2.sml,v $
 *  Revision 1.6  1998/02/18 11:56:00  mitchell
 *  [Bug #30349]
 *  Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.5  1997/11/21  10:42:40  daveb
 *  [Bug #30323]
 *  Removed use of Shell.Build.
 *
 *  Revision 1.4  1997/08/07  13:57:10  brucem
 *  [Bug #30245]
 *  ARRAY2 has changed, fix the test so it works with the new sig and struct.
 *
 *  Revision 1.3  1997/05/28  11:00:16  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.2  1997/03/03  10:44:25  matthew
 *  Adding flush to print
 *
 *  Revision 1.1  1997/02/28  16:52:46  matthew
 *  new unit
 *
*)

  fun maken (n,m) = Array2.tabulate Array2.RowMajor (n,m,fn (i,j) =>i*m+j)

  fun allreg a = {base = a, row = 0, col = 0, nrows = NONE, ncols = NONE}

  fun mkreg (a, r, c, h, w) =
                {base = a, row = r, col = c, nrows = SOME h, ncols = SOME w}

  fun iprint a =
    let
      fun pad s = if size s < 3 then pad (" " ^ s) else s
      fun one (i,j,n) =
        print ((if j = 0 then "\n" else "") ^ pad (Int.toString n) ^ " ")
    in
      Array2.appi Array2.RowMajor one (allreg a);
      print "\n"
    end;

  val _ = 
    let
      val i = ref (~1)
      val a = Array2.tabulate Array2.RowMajor
                 (4, 6, (fn _ => (i:= !i+1; !i)))
      val b = Array2.tabulate Array2.RowMajor 
                 (4, 6, (fn (a,_) => (a)))
      val c = Array2.tabulate Array2.ColMajor 
                 (4, 6, (fn (_,a) => (a)))
    in
      print "tabulate RowMajor\n";
      iprint a ; iprint b ; iprint c
    end

  val _ = 
    let
      val i = ref (~1)
      val a = Array2.tabulate Array2.ColMajor 
                 (4, 6, (fn _ => (i:= !i+1; !i)))
      val b = Array2.tabulate Array2.ColMajor 
                 (4, 6, (fn (a,_) => (a)))
      val c = Array2.tabulate Array2.ColMajor 
                 (4, 6, (fn (_,a) => (a)))
    in
      print "tabulate ColMajor \n";
      iprint a ; iprint b ; iprint c
    end
  

  fun copytest (a,b,c,d,e,f) =
    let val arr = maken (6,8)
    in
      Array2.copy {src=mkreg (arr, a,b,c,d), dst=arr, dst_row=e, dst_col=f};
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
      val dst = Array2.array (10,10,0)
    in
      Array2.copy {src=mkreg (arr, a,b,c,d), dst_row=e, dst_col = f, dst=dst};
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
    (Array2.app Array2.RowMajor (fn x => print (Int.toString x ^ " "))
       (maken (4,6));
     print "\n") ;

  val _ = 
    (Array2.app Array2.ColMajor (fn x => print (Int.toString x ^ " "))
       (maken (4,6));
     print "\n") ;

  val _ = 
    (Array2.appi Array2.RowMajor 
       (fn (i,j,x) => if i <> j then () else print (Int.toString x ^ " "))
       (allreg (maken (4, 6)));
      print "\n") ;

  val _ = 
    (Array2.appi Array2.ColMajor 
       (fn (i,j,x) => if i <> j then () else print (Int.toString x ^ " "))
       (allreg (maken (4, 6)));
      print "\n") ;

  val _ = (Array2.appi Array2.RowMajor
            (fn (i,j,x) => if i = j then () else print (Int.toString x ^ " "))
            {base = maken(4, 6), row=1,col=1, nrows=SOME 3, ncols=SOME 3};
           print "\n") ;

  val _ = (Array2.appi Array2.ColMajor
            (fn (i,j,x) => if i = j then () else print (Int.toString x ^ " "))
            {base = maken(4, 6), row=1,col=1, nrows=SOME 3, ncols=SOME 3};
           print "\n") ;


  print "modify test\n";
  val _ = 
    let
      val a = maken (4,6)
    in
      Array2.modifyi Array2.RowMajor 
        (fn (i,j,x) => if i = j then 0 else x + x) (allreg a);
      iprint a
    end;

  val _ = 
    let
      val a = maken (4,6)
    in
      Array2.modifyi Array2.RowMajor 
        (fn (i,j,x) => if i = j then 0 else x + x) (mkreg(a, 1,1,3,4));
      iprint a
    end;

  val _ = 
    let 
      val a = Array2.array (4, 6, 0)
      val i = ref (~1)
      fun m _ = (i:=(!i+1); !i)
    in
      print "modify RowMajor\n";
      Array2.modify Array2.RowMajor m a;
      iprint a
    end ;

  val _ = 
    let 
      val a = Array2.array (4, 6, 0)
      val i = ref (~1)
      fun m _ = (i:=(!i+1); !i)
    in
      print "modify ColMajor\n";
      Array2.modify Array2.ColMajor m a;
      iprint a
    end ;


  val _ = print "fold test\n";
  val fold1 = rev (Array2.fold Array2.RowMajor op:: [] (maken (4,4)));
  val fold2 = rev (Array2.fold Array2.ColMajor op:: [] (maken (4,4)));
  val fold3 = (ignore(rev (Array2.foldi Array2.RowMajor (fn _ => raise Div) []
               (mkreg (maken(4, 4), ~1,1,2,2)))); "FAIL")
               handle Subscript => "OK";
  val fold4 = (ignore(rev (Array2.foldi Array2.RowMajor (fn _ => raise Div) []
               (mkreg (maken(4, 4), 100,1,2,2)))); "FAIL")
               handle Subscript => "OK";
  val fold5 = (ignore(rev (Array2.foldi Array2.RowMajor (fn _ => raise Div) []
               (mkreg (maken(4, 4), 1,1,200,2)))); "FAIL")
               handle Subscript => "OK";
  val fold6 = rev (Array2.fold Array2.ColMajor op:: [] (maken (4,4)));

