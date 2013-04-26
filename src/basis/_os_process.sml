(* Copyright (C) 1996 Harlequin Ltd.
 *
 * Revision Log
 * ------------
 *
 * $Log: _os_process.sml,v $
 * Revision 1.4  1999/03/20 22:24:56  daveb
 * Removed the equality attribute from type status; added isSuccess.
 *
 * Revision 1.3  1996/10/03  15:09:05  io
 * [Bug #1614]
 * remove redundant requires
 *
 * Revision 1.2  1996/05/08  14:20:59  stephenb
 * Update wrt move of file "main" to basis.
 *
 * Revision 1.1  1996/04/18  15:11:45  jont
 * new unit
 *
 *  Revision 1.1  1996/04/17  15:30:12  stephenb
 *  new unit
 *
 *
 *)

require "os_process";
require "exit";

functor OSProcess (structure Exit : EXIT) : OS_PROCESS =
  struct
    val env = MLWorks.Internal.Runtime.environment

    type status = Exit.status

    val success = Exit.success

    val failure = Exit.failure

    val isSuccess = Exit.isSuccess

    val system : string -> status = env "system os system"

    val terminate = Exit.terminate

    val atExit = Exit.atExit

    val exit = Exit.exit

    val getEnv : string -> string option = env "system os getenv"

  end
