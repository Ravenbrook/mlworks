(*  ==== Testing ====
 * this tests that the IEEEReal functions work properly.
 *  Copyright (C) 1997 The Harlequin Group Ltd.
 *
    Result: OK
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: ieeetest.sml,v $
 *  Revision 1.3  1998/02/24 12:55:48  mitchell
 *  [Bug #30335]
 *  Fix testsuite as IEEEReal.decimal_approx is now an abstract type
 *
 *  Revision 1.2  1997/11/21  10:43:58  daveb
 *  [Bug #30323]
 *
 *  Revision 1.1  1997/03/03  16:57:50  matthew
 *  new unit
 *
 *
 *
*)


fun opt (SOME x) = x | opt _ = raise Div
val f = IEEEReal.toString o opt o IEEEReal.fromString;
val f = IEEEReal.toString o Real.toDecimal o Real.fromDecimal o opt o IEEEReal.fromString;

val rep = MLWorks.Internal.Value.real_to_string
fun eqrep (x,y) = rep x = rep y

fun check s =
  let
    (* make a decimal rep *)
    val x = opt (IEEEReal.fromString ("  " ^ s ^ "foobar"))
    fun eq_decimal_approx(de1, de2) =
      IEEEReal.class(de1) = IEEEReal.class(de2) andalso 
      IEEEReal.signBit(de1) = IEEEReal.signBit(de2) andalso
      IEEEReal.digits(de1) = IEEEReal.digits(de2) andalso
      IEEEReal.exp(de1) = IEEEReal.exp(de2)
  in
    (* and then check all is well *)
    eq_decimal_approx(x, opt (IEEEReal.fromString (IEEEReal.toString x))) andalso
    eqrep (opt (Real.fromString s),Real.fromDecimal x)
  end;

val t1 =
  map check [" 1.0",
             " InFiNiTy",
             "-InFiNiTy",
             "InFinI",
             "NaN(1234)",
             "nan"];

val t2 =
  map check ["0.1E+1",
             ".1E+1",
             "10.0E~1",
             "1.2345E123",
             "1.2345E~123",
             "~1.2345E123",
             "~1.2345E~123"];

val t3 =
  map check ["0.1E+",
             ".1E",
             "10.0E~",
             "1.2345E~",
             "~1."];

val t4 =
  map check ["1.0",
             "1.00000",
             "0.1E1",
             "0.001E3",
             "1000E~4"];

