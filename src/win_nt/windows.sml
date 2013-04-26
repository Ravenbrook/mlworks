(* The windows signature *)
(*
 * Copyright (c) 1998 Harlequin Group plc
 * All rights reserved
 *
 * The Windows signature defines useful OS functions for programming on
 * Microsoft Windows systems.  It does not implement the whole Win32 API;
 * in fact it doesn't include any GUI operations at all.  That task is
 * left to a future Win32 library.  This structure provides a subset of
 * useful functions from the Win32 interface, and also provides a place
 * for higher-level functions specific to Windows.
 *
 * To begin with, this structure provides Registry operations, simple DDE
 * functionality, some process creation functions, and a few operations
 * on the file system.
 *
 * $Log: windows.sml,v $
 * Revision 1.5  1999/05/13 15:34:06  daveb
 * [Bug #190553]
 * Added exit function.
 *
 * Revision 1.4  1999/03/18  14:24:13  daveb
 * [Bug #190523]
 * Revised to new spec, mainly involving changes to execute functions.
 *
 * Revision 1.3  1999/02/02  16:02:16  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.2  1998/10/27  14:18:52  jont
 * [Bug #70220]
 * Add reap function
 *
 * Revision 1.1  1998/04/07  14:26:43  jont
 * new unit
 ** No reason given. **
 *
 *
 *)

require "^.basis.__sys_word";
require "^.basis.__text_io";
require "^.basis.__bin_io";
require "__os";
require "__time";
require "^.basis.bit_flags";

signature WINDOWS =
  sig
    (* Access security settings for opening and creating keys in
       the registry. *)
    structure Key :
      sig
	include BIT_FLAGS

        val allAccess: flags
	(* Combination of queryValue, enumerateSubKeys, notify,
         createSubKey, createLink, and setValue access. *)

	val createLink: flags
	(* Permission to create a symbolic link. *)

	val createSubKey: flags
	(* Permission to create subkeys. *)

	val enumerateSubKeys: flags
	(* Permission to enumerate subkeys. *)

	val execute: flags
	(* Permission for read access. *)

	val notify: flags
	(* Permission for change notification. *)

	val queryValue: flags
	(* Permission to query subkey data. *)

	val read: flags
	(* Combination of queryValue, enumerateSubKeys, and
         notify access. *)

	val setValue: flags
	(* Permission to set subkey data. *)

	val write: flags
      (* Combination of setValue and createSubKey access. *)
      end


    (* Windows Registry Functions *)
    structure Reg :
      sig
	(* Type of registry key values. *)
	eqtype hkey

        (* Top level registry keys. *)
        val classesRoot : hkey
	val currentUser : hkey
	val localMachine : hkey
	val users : hkey

	datatype options =
	  VOLATILE
        (* This key is volatile; the information is stored in memory and is
	 not preserved when the system is restarted. *)
	| NON_VOLATILE
        (* This key is not volatile; the information is stored in a file and
	 is preserved when the system is restarted.  *)
 
	datatype create_result =
	  CREATED_NEW_KEY of hkey
	| OPENED_EXISTING_KEY of hkey

	(* Operations *)

	val createKeyEx : hkey * string * options * Key.flags ->
	  create_result option
       (* raises OS.SysErr *)
	(* createKeyEx (hkey, subkey, regopts, regsam) --
         opens or creates a subkey of hkey, with options regopts and the
         security access specified by regsam. *)
	(* Implementation: This passes NULL Class and SECURITY_ATTRIBUTE
         arguments to the Win32 call. *)
 
	val openKeyEx : hkey * string * Key.flags -> hkey option
       (* raises OS.SysErr *)
	(* openKeyEx (hkey, subkey, regsam) --
         opens a subkey of hkey with the security access specified
         by regsam. *)
 
	val queryValueEx : hkey * string -> string
	(* raises OS.SysErr*)
	(* queryValueEx (hkey, name) --
         returns the data associated with the value name of the open key hkey.
         In this structure, only text values are supported. *)
	(* Implementation:  This corresponds to two calls of the Win32 function.
         The first finds the length of the string.  The second reads the
         string into a buffer of the appropriate length. *)
 
	val setValueEx : hkey * string * string -> unit
	(* raises OS.SysErr*)
	(* setValueEx (hkey, name, str) --
         sets the value name of the open key hkey to the string str.
         In this structure, only text values are supported. *)
 
	val closeKey : hkey -> unit
	(* raises OS.SysErr*)
	(* closeKey hkey --
         closes hkey. *)

	val deleteKey : hkey * string -> unit
      (* raises OS.SysErr*)
      (* deleteKey (hkey, subkey) --
       deletes the subkey of hkey. *)
      end	 
 
    (* A high-level client-side interface for simple DDE interactions.
       All transactions are synchronous.  Advise loops and poke
       transactions are not supported by this interface. *)
    structure DDE :
      sig

	type info

	val startDialog: string * string -> info
	(* raises OS.SysErr*)
	(* startDialog (service, topic) --
         Initialises DDE and connects to the given service and topic.
         Returns the info value created by these operations. *)

	val executeString: info * string * int * int -> unit
	(* raises OS.SysErr*)
	(* executeString (info, cmd, retry, delay) --
         Attempts to execute the command cmd on the service and topic
         specified by the info value.  The retry argument specifies the
         number of times to attempt the transaction if the server is
         busy, pausing for delay milliseconds between each attempt. *)
 
	val stopDialog: info -> unit
      (* stopDialog info --
       Disconnects the service and topic specified by the info argument
       ands frees the associated resources. *)
      end


    (* File system *)

    val fileTimeToLocalFileTime: Time.time -> Time.time
    (* fileTimeToLocalFileTime t --
     adjusts a UTC time to the local time.  *)
    (* This is rarely needed; most uses of times should use absolute UTC
     values.  Manipulation of time zones is normally done using dates.
     But FAT file systems store the modification times of files using
     local time.  Normally this is invisible, as GetFileTime adjusts
     this to give a UTC value.  But if you need the actual value stored
     in the file system, this function allows you to do so. *)

    val localFileTimeToFileTime: Time.time -> Time.time
    (* localFileTimeToFileTime f --
     the inverse of fileTimeToLocalFileTime. *)

    val getVolumeInformation: string ->
      {volumeName: string,
       systemName: string,
       serialNumber: SysWord.word,
       maximumComponentLength: int}
    (* raises OS.SysError *)
    (* getVolumeInformation rootPathName --
       returns information about the filesystem and volume specified by
	the root path name.  The volumeName field contains the name of the
       volume, the systemName field contains its type (e.g. "FAT" or "NTFS),
	the serialNumber field contains the serial number, and the 
       maximumComponentLength field specifies the maximum length of any
	component of a path name on this system.  *)


    (* Process creation *)

    val findExecutable: string -> string option
    (* raises OS.SysErr *)
    (* findExecutable file --
       returns the executable associated with file, or NONE if no such file
       exists. *)

    val launchApplication: string * string list -> unit
    (* raises OS.SysErr *)
    (* launchApplication (file, arguments) --
       runs the specified executable, passing it the arguments.  Raises
	OS.SysErr if file is not an executable, or if it cannot be run. *)
    (* Implementation: This should be implemented using ShellExecute. 
	It should pass SW_SHOWNORMAL to the underlying API call. *)

    val openDocument: string -> unit
    (* raises OS.SysErr*)
    (* shellExecute (file) --
       opens file with the associated application. *)
    (* Implementation: This should pass SW_SHOWNORMAL to the underlying
ShellExecute API call. *)

    val simpleExecute: (string * string list) -> OS.Process.status
    (* raises OS.SysErr *)
    (* simpleExecute (module, args) --
       spawns the process specified by module, with command-line arguments
       args, redirecting standard input and standard output to the null
       device.  Then waits for the sub-process to terminate, and returns
       its status.  *)
    (* Implementation: This corresponds to the use of CreateProcess as
       detailed in the Windows SDK document "Creating a Child Process
       with Redirected Input and Output". *)

    val hasOwnConsole: unit -> bool
    (* raises OS.SysErr *)
    (* hasOwnConsole () --
       raises OS.SysErr if the application isn't a console app. Otherwise
       returns true if the process was started from a console window,
       in which case the standard input, output and error streams will be
       connected to that window.  Otherwise it returns false. *)

    type ('a, 'b) proc
    (* Type of processes created by execute.  The arguments are witness
       types for the types of streams that can be returned.  
     *)

    val execute: (string * string list) -> ('a, 'b) proc
    (* raises OS.SysErr*)
    (* execute (module, args) --
       spawns the process specified by module, with command-line arguments
       args. *)
    (* Implementation: This corresponds to the use of CreateProcess as
       detailed in the Windows SDK document "Creating a Child Process
       with Redirected Input and Output". In addition, the redirection code
	should be wrapped in a call to AllocConsole and a conditional call to
       FreeConsole, to ensure that the calling process has standard streams
       to redirect.  *)

    val binInstreamOf: (BinIO.instream, 'a) proc -> BinIO.instream
    val textInstreamOf: (TextIO.instream, 'a) proc -> TextIO.instream
    (* ...InstreamOf p --
       returns a text or binary instream connected to the stdOut of p. *)

    val binOutstreamOf: ('a, BinIO.outstream) proc -> BinIO.outstream
    val textOutstreamOf: ('a, TextIO.outstream) proc -> TextIO.outstream
    (* ...OutstreamOf p --
       returns a text or binary outstream connected to the stdIn of p. *)

    val reap: ('a, 'b) proc -> OS.Process.status
    (* reap pr --
       closes the standard streams associated with pr, and then 
       suspends the current process until the system process corresponding
       to pr terminates.  Returns the exit status given by pr when it
       terminates. *)

    (* The Status structure defines the possible interpretations of 
	OS.Process.status values. *)
    structure Status:
    sig
      type status = SysWord.word
	val accessViolation: status
	val arrayBoundsExceeded: status
	val breakpoint: status
	val controlCExit: status
	val datatypeMisalignment: status
	val floatDenormalOperand: status
	val floatDivideByZero: status
	val floatInexactResult: status
	val floatInvalidOperation: status
        val floatOverflow: status
	val floatStackCheck: status
	val floatUnderflow: status
	val guardPageViolation: status
	val integerDivideByZero: status
	val integerOverflow: status
	val illegalInstruction: status
	val invalidDisposition: status
	val invalidHandle: status
	val inPageError: status
	val noncontinuableException: status
	val pending: status
	val privilegedInstruction: status
	val singleStep: status
	val stackOverflow: status
	val timeout: status
	val userAPC: status
    end

    (* OS.Process.status *)
    val fromStatus:  OS.Process.status -> Status.status
    (* fromStatus s --
       decodes the abstract value s to the system-specific information. *)

    val exit: Status.status -> 'a
    (* Exits the process, first calling any functions registered by
       OS.Process.atExit. *)

end


