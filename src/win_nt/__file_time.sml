(* FileTime structure *)
(*
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * FS independent access to actual time stamp stored with file
 * Win32 version
 *
 * $Log: __file_time.sml,v $
 * Revision 1.3  1998/07/16 12:43:32  jont
 * [Bug #50093]
 * Cope with Samba and VFAT
 *
 * Revision 1.2  1998/04/07  17:01:43  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *)

require "__windows";
require "__os";
require "^.main.file_time";
require "^.basis.__string";

structure FileTime : FILE_TIME =
  struct
    fun modTime path =
      let
	val file_time = OS.FileSys.modTime path
	val converted = Windows.fileTimeToLocalFileTime file_time
      (* Should we clamp this? *)
      (* The considered answer is no *)
      (* Clamping was important when we object files containing stamps *)
      (* of other obejct files *)
      (* We no longer do this. *)
      (* The only point at which a lack of clamping could hurt *)
      (* is if an system of source and object files is copied from NTFS to FAT *)
      (* and then recompiled *)
      (* I think this is a hit we can be prepared to take *)
      in
	if file_time = converted then
	  file_time
	else
	  (* Need to do the full monty here *)
	  let
	    val fullPath = OS.FileSys.fullPath path
	    (* Now determine the drive type *)
	    val root =
	      if size fullPath <= 3 then
		raise OS.SysErr("fullPath of '" ^ path ^ "' has returned '" ^ fullPath, NONE)
	      else
		if String.sub(fullPath, 1) = #":" then
		  (* Standard DOS style drive *)
		  String.substring(fullPath, 0, 3)
		else
		  (* Remote mounted stuff \\foo\bar *)
		  let
		    val name = explode fullPath
		  in
		    case name of
		      #"\\" :: #"\\" :: name' =>
		      let
			fun to_next_back([], acc) = raise OS.SysErr("malformed root in '" ^ fullPath, NONE)
			  | to_next_back(#"\\" :: name, acc) = (name, #"\\" :: acc)
			  | to_next_back(x :: name, acc) = to_next_back(name, x :: acc)
		      in
			implode(#1(to_next_back(to_next_back(name, []))))
		      end
		    | _ => raise OS.SysErr("malformed root in '" ^ fullPath, NONE)
		  end
	    val {systemName, ...} = Windows.getVolumeInformation root
	  in
	    case systemName of
	      "NTFS" => (* No adjustment for NTFS (but what about DSE?) *) file_time
	    | "FAT" => converted
	    | "VFAT" => converted
	    | "HPFS" => (* We don't know what to do, so don't adjust *) file_time
	    | "FAT32" => converted (* Assumed correct behvaviour *)
	    | "Samba" => (* No adjustment for unix based file system *) file_time
	    | _ => (* Again, unknown type, so do nothing *)
		(print("Warning, unknown file system type '" ^ systemName ^ "' found during modTime\n");
		 file_time)
	  end

      end
  end
