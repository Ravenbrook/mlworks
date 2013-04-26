(*   ==== SCON EQAULITY OF MEANING ====
 *              STRUCTURE
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module contains an Ident.SCon equality of meaning function
 *
 *  $Log: __scons.sml,v $
 *  Revision 1.1  1995/07/19 16:50:49  jont
 *  new unit
 *  No reason given
 *
 *)

require "../utils/__bignum";
require "__ident";
require "_scons";

structure Scons_ =
  Scons(structure Ident = Ident_
	structure BigNum = BigNum_)
