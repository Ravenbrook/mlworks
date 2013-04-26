(* License server implementation.
 *
 * Copyright (c) Harlequin Ltd. 1996.
 *
 * $Log: __license.sml,v $
 * Revision 1.3  1999/05/13 09:50:05  daveb
 * [Bug #190553]
 * Replaced use of basis/exit with utils/mlworks_exit.
 *
 *  Revision 1.2  1998/06/11  14:18:14  jkbrook
 *  [Bug #30411]
 *  Adding FREE edition
 *
 *  Revision 1.1  1996/11/06  13:16:13  daveb
 *  new unit
 *  Interface to the licensing code in the runtime.
 *
 *
 *)

require "__version";
require "_license";

structure License_ =
  License (
    structure Version = Version_
  );
