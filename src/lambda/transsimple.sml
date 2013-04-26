(*
 * $Log: transsimple.sml,v $
 * Revision 1.6  1997/02/05 13:40:54  matthew
 * Removing trans_lamb
 *
 * Revision 1.5  1997/01/06  16:38:59  jont
 * [Bug #1633]
 * Add copyright message
 *
 * Revision 1.4  1996/11/14  15:33:55  matthew
 * Simplifications and rationalizations
 *
 * Revision 1.3  1994/10/12  11:00:28  matthew
 * Renamed simpletypes to simplelambdatypes
 *
 * Copyright (c) 1997 Harlequin Ltd.
 *)

require "lambdatypes";

signature TRANSSIMPLE =
  sig
    structure LambdaTypes : LAMBDATYPES

    val trans_program : LambdaTypes.program -> LambdaTypes.LambdaExp
  end

