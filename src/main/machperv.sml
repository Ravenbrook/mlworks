(*   ==== MACHINE SPECIFICATION (PERVASIVES) ====
 *              SIGNATURE
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module contains some information necessary to generate MIR code
 *  suitable for the machine code generator.  It specifies which pervasives
 * can be generated as in-line code.
 *
 *  Revision Log
 *  $Log: machperv.sml,v $
 *  Revision 1.3  1997/01/21 11:23:19  matthew
 *  Adding options parameter
 *
 * Revision 1.2  1994/09/09  16:34:54  jont
 * Move in machine specific stuff from _pervasives.sml
 *
Revision 1.1  1993/12/17  12:55:35  io
Initial revision

Revision 1.1  1992/11/21  19:14:43  jont
Initial revision

 *)

require "../main/pervasives";


signature MACHPERV =
  sig
    structure Pervasives : PERVASIVES
    type CompilerOptions
    (*  === MACHINE CAPABILITIES ===  *)

    val is_inline : CompilerOptions * Pervasives.pervasive -> bool

    val is_fun : Pervasives.pervasive -> bool

    val implicit_references : Pervasives.pervasive -> Pervasives.pervasive list

  end
