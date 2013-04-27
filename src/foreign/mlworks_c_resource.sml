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
 * The malloc function in MLWORKS_C_INTERFACE and make and makeArray functions
 * in MLWORKS_C_POINTER result in memory being allocated using malloc.
 * This memory is not subject to garbage collection and so must be managed
 * manually by the programmer.
 * 
 * MLWORKS_C_RESOURCE defines some idoms for manual resource (memory)
 * management.  The aim of the idioms is to help avoid mistakes that lead
 * to leaking memory allocated via the MLWorks C interface.
 *
 * Revision Log
 * ------------
 * $Log: mlworks_c_resource.sml,v $
 * Revision 1.2  1997/07/03 09:42:18  stephenb
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *)


signature MLWORKS_C_RESOURCE =
  sig

    type 'a ptr

    (* withResource close resource action
     * 
     * withResource enforces a stack-like discipline on `resource'.
     * withResource applies `action' to `resource' and ensures that
     * `close' is applied to `resource' whether `action' returns a value
     * or raises an exception.  More specifically :-
     *
     * If `action' does not raise an exception, then `close' is applied
     * to resource and the result of applying `action' to `resource'
     * is returned.
     *
     * If `action' raises an exception, then `close' is applied to `resource'
     * and the exception is then propagated up through withResource.
     *
     * The result is undefined if `resource' is referred outside of `action'
     * either by having `action' return `resource' or store a reference 
     * to `resource'.
     * 
     * The following example shows how withResource can be used to define
     * the function withCString which encapsulates the conversion of an
     * SML string into a C char * :-
     * 
     *   structure C = MLWorksCInterface
     *
     *   fun withCString (str:string) (action: C.Char.char C.ptr -> 'a) = 
     *     withResource (C.CharPtr.free, str, action)
     *
     *   withCString "foo"
     *     (fn cFoo =>
     *       (* do something with (a possibly NULL) cFoo here,
     *        * safe in the knowledge that no matter what happens,
     *        * cFoo will be deleted.
     *        *)
     *       )
     * 
     * Note that in the above example, if cFoo is NULL and whatever
     * code that would replace the comment raised an exception, then
     * C.CharPtr.free would be called on a NULL pointer.  This is legal
     * in ANSI/ISO C and so is supported by this interface.  However,
     * not all routines that release resources can accept a NULL pointer
     *
     * For example, assuming that the following have been defined 
     * as an interface to the C stdio functions fopen and fclose :-
     *   
     *   type FILE 
     *   val fclose : FILE C.ptr -> unit
     *   val fopen : C.Char.char C.ptr * C.Char.char C.ptr -> FILE C.ptr
     *
     * then to ensure that a file is always closed, the following function
     * could be defined :-
     *
     *   fun withFile (fileName: string, mode: string) action = 
     *     withCString fileName
     *       (fn cFileName =>
     *         withCString mode
     *           (fn cMode =>
     *              withResource (fclose, fopen (cFileName, cMode), action))
     *
     * and it could be used as follows :-
     *
     *   withFile ("dates", "r")
     *     (fn (file: FILE C.ptr) =>
     *       (*
     *        * do something with a possibly NULL file ...
     *        *)
     *       )
     *
     * Note however, that if file is NULL and that any code that replaces
     * the comment in the above raises an exception, then fclose will be
     * called with a NULL pointer and this will result in undefined 
     * behaviour.  Therefore, unless you are certain that the close routine
     * can accept a NULL pointer you should not use withResource, but instead
     * use the withNonNullResource variant.
     *)
    val withResource : ('a -> 'b) * 'a * ('a -> 'c) -> 'c



    (* withNonNullResource close exception resource action
     * 
     * withNonNullResource is a variant of withResource that only works
     * for pointers (something of type 'a MLWorksCInterface.ptr).  
     *
     * withNonNullResource checks that the pointer points to a non-NULL
     * location before applying `action'.  If the resource is NULL
     * then the exception is raised and the action is not performed.
     * 
     * As an example of using withNonNullResource consider again the 
     * withFile example given in the description of withResource.  The
     * following uses withNonNullResource instead to ensure that all
     * possible errors are detected and converted into exceptions :-
     *
     *   structure C = MLWorksCInterface;
     *
     *   exception OutOfMemory
     *
     *   fun withCString (str:string) (action: C.Char.char C.ptr -> 'a) = 
     *     withNonNullResource (C.CharPtr.free, OutOfMemory, str, action)
     *
     *   exception CannotOpenFile of string
     *
     *   fun withFile (fileName: string, mode: string) action = 
     *     withCString fileName
     *       (fn cFileName =>
     *         withCString mode
     *           (fn cMode =>
     *              let
     *                val file = fopen (cFileName, cMode)
     *                val exn = CannotOpenFile fileName
     *              in
     *                withNonNullResource (fclose, exn, file, action)
     *              end))
     *
     *   withFile ("dates", "r")
     *     (fn (file: FILE C.ptr) =>
     *       (*
     *        * do something with an open file sure in
     *        * the knowledge that the file will be closed when then
     *        * action is complete or if an exception is raised.
     *        *)
     *       )
     *)
    val withNonNullResource :
      (''a ptr -> 'b) * exn * ''a ptr * (''a ptr -> 'c) -> 'c

  end
