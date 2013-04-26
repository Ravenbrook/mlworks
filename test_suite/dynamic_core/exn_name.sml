(*
 *
 * Result: OK
 *
 * $Log: exn_name.sml,v $
 * Revision 1.3  1998/02/24 12:26:21  jont
 * [Bug #70057]
 * Modify now that full location info in exception names
 *
 * Revision 1.2  1998/02/20  14:24:04  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 * Copyright (c) 1998 Harlequin Group plc
 *)

exception Foo;
MLWorks.Internal.Value.exn_name Foo;
