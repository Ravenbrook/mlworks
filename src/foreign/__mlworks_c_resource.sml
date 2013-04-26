(* Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * MLWorksCResource defines some idoms for manual resource (memory) management
 *
 * Revision Log
 * ------------
 * $Log: __mlworks_c_resource.sml,v $
 * Revision 1.3  1998/10/02 14:13:39  jkbrook
 * [Bug #70186]
 * Insert ignores to get rid of warnings
 *
 *  Revision 1.2  1997/07/03  09:41:40  stephenb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *)

require "__mlworks_c_interface";
require "mlworks_c_resource";

structure MLWorksCResource : MLWORKS_C_RESOURCE =
  struct

    type 'a ptr = 'a MLWorksCInterface.ptr

    fun withResource (close, resource, f)=
      let
        val r = (f resource) handle exn => (ignore(close resource); raise exn)
      in
        ignore(close resource);
        r
      end


    fun withNonNullResource (close, exn, resource, f) =
      if resource = MLWorksCInterface.null then
        raise exn
      else
        withResource (close, resource, f)

  end
