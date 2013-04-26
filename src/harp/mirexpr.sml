(*  ==== MIR Expression analyser ====
 *
 *  Copyright (C) 1994 Harlequin Ltd.
 *  $Log: mirexpr.sml,v $
 *  Revision 1.2  1994/07/29 10:31:52  matthew
 *  Add simple_transform function
 *
# Revision 1.1  1994/04/12  14:43:25  jont
# new file
#
 *)

require "mirtypes";


signature MIREXPR = 
  sig
    structure MirTypes		: MIRTYPES

    val transform : MirTypes.block list -> MirTypes.block list
    val simple_transform : MirTypes.block list -> MirTypes.block list

  end
