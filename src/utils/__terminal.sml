(* __terminal.sml the structure *)
(*
 * $Log: __terminal.sml,v $
 * Revision 1.4  1998/02/20 09:32:47  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.3  1998/02/19  16:07:17  jont
 * [Bug #70070]
 * Correct typo
 *
 * Revision 1.2  1998/02/19  16:03:56  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 * Copyright (c) 1998 Harlequin Group plc
 *)

require "terminal";

structure Terminal : TERMINAL =
  struct
    val terminalIO =
      let
	val current = MLWorks.Internal.StandardIO.currentIO()
	val _ = MLWorks.Internal.StandardIO.resetIO()
	val res = MLWorks.Internal.StandardIO.currentIO()
      in
	MLWorks.Internal.StandardIO.redirectIO current;
	res
      end
    fun output s = (ignore(#put(#output(terminalIO)) {buf=s,i=0,sz=NONE});())
  end;
