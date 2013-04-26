(*   ==== SCON EQAULITY OF MEANING ====
 *              SIGNATURE
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module contains an Ident.SCon equality of meaning function
 *
 *  $Log: scons.sml,v $
 *  Revision 1.1  1995/07/19 16:48:43  jont
 *  new unit
 *  No reason given
 *
 *)

signature SCONS =

  sig
    type SCon
    val scon_eqval : SCon * SCon -> bool
  end
