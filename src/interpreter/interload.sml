(*  ==== INTERPRETER LINK/LOADER ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *
 *  Revision Log
 *  ------------
 *  $Log: interload.sml,v $
 *  Revision 1.2  1993/03/11 11:08:45  matthew
 *  Signature revisions
 *
 *  Revision 1.1  1992/10/09  08:11:39  richard
 *  Initial revision
 *
 *)

require "inter_envtypes";

signature INTERLOAD =
  sig
    structure Inter_EnvTypes : INTER_ENVTYPES

    type Module  (* was MachTypes.Module *)
    val load :
      (('a -> 'b) -> ('a -> 'b)) ->
      Inter_EnvTypes.inter_env * (string -> MLWorks.Internal.Value.T) ->
      Module ->
      MLWorks.Internal.Value.T
  end;

      
