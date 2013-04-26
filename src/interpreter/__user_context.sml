(* User contexts
 *
 * Copyright (C) 1995 Harlequin Ltd.
 *
 * $Log: __user_context.sml,v $
 * Revision 1.2  1996/04/09 16:58:11  daveb
 * Added Preferences parameter.
 *
 * Revision 1.1  1995/05/01  08:53:55  daveb
 * new unit
 * Separated user context code from shelltypes.sml.
 *
 *
 *)

require "__incremental";
require "__interprint";
require "../main/__user_options";
require "../main/__preferences";
require "../utils/__btree";
require "../utils/__lists";
require "../utils/__crash";
require "_user_context";

structure UserContext_ = UserContext (
  structure Incremental = Incremental_
  structure InterPrint = InterPrint_
  structure UserOptions = UserOptions_
  structure Preferences = Preferences_
  structure Map = BTree_
  structure Lists = Lists_
  structure Crash = Crash_
)
