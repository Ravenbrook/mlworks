(*
 * Check that datatype replication builds the correct type constructor
 * parser environment.
 * 
 * Result: OK
 *  
 * $Log: datrepl.sml,v $
 * Revision 1.2  1997/07/31 16:51:27  daveb
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 * Copyright (C) 1997 The Harlequin Group Ltd.  All rights reserved.
 *)

structure Outer =
  struct
    structure Inner :
      sig
        datatype 'a the_datatype = PLAIN | WITH_DATA of 'a
      end =
      struct
        datatype 'a the_datatype = PLAIN | WITH_DATA of 'a
      end

    datatype the_datatype = datatype Inner.the_datatype

    fun aFunction (WITH_DATA _) = true | aFunction _ = false

  end;
