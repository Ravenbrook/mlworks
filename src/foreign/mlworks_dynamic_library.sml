(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 * MLWORKS_DYNAMIC_LIBRARY provides a mechanism for dynamically loading
 * code, from a .DLL under Win32 or .so under Unix, into MLWorks and 
 * binding to an SML function.
 * 
 * Revision Log
 * ------------
 * $Log: mlworks_dynamic_library.sml,v $
 * Revision 1.2  1997/07/03 09:43:37  stephenb
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *)

signature MLWORKS_DYNAMIC_LIBRARY =
  sig
    type library

    (*
     * syerror and SysErr are the same type and exception that are
     * defined in the OS and MLWORKS_C_INTERFACE signatures.
     *)
    type syserror
    exception SysErr of (string * syserror option)


    (* openLibrary fileName initialisationFunctionName
     *
     * openLibrary opens a dynamic library -- a .so under Unix  
     * and a .DLL under Win32.  The first argument is the name of
     * the library including the extension (.so or .dll as appropriate).
     * and the second is the name of the initialisation function to
     * call when the library is loaded.  If the library cannot be loaded
     * then the SysErr exception is raised.
     *
     *   val x = openLibrary ("ndbm.so", "mlw_stub_init_ndbm");
     *
     * The initialisation function registers any functions in the .so/.DLL
     * that need to be called from MLWorks.  Note that the names from
     * every .so/.DLL is registered in the same global namespace.
     *)
    val openLibrary : string * string -> library



    (* bind functionName
     * 
     * bind binds a function with the given functionName to an SML value.
     * For example, the following binds the C function called "add" to the
     * SML function called addInt :-
     *
     *   structure C = MLWorksCInterface
     *   val addInt : C.Int.int -> C.Int.int = bind "add"
     * 
     * Note that bind does not take a library as an argument since as noted
     * in the description of openLibrary the initialisation function for each
     * library makes any exported functions available in a global namespace.
     *)
    val bind : string -> 'a



    (* closeLibrary library finisalisationFunctionName
     *
     * closeLibrary closes the library and if a finalisationFunctionName
     * is supplied, calls that function before the library is closed.
     *
     * This should be called when you no longer need to reference the 
     * functions in the library.
     *
     * Once closeLibrary has been called on a library, attempting to
     * call any of the functions that are defined in the library has
     * an undefined effect.
     *)
    val closeLibrary : library * string option -> unit


  end
