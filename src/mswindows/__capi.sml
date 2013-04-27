(*
 * $Log: __capi.sml,v $
 * Revision 1.9  1998/06/11 09:38:37  johnh
 * [Bug #30411]
 * Add support for free edition splash screen - need version information.
 *
 * Revision 1.8  1998/04/01  12:07:52  jont
 * [Bug #70086]
 * Windows_ has become WindowsGui_
 *
 * Revision 1.7  1997/10/29  11:43:46  johnh
 * [Bug #30187]
 * Adding word32 structure.
 *
 * Revision 1.6  1996/10/31  17:04:44  daveb
 * Renamed Windows_ to Windows, as users will see it.
 *
 * Revision 1.5  1996/01/31  12:06:56  matthew
 * Adding CapiTypes
 *
 * Revision 1.4  1996/01/12  11:03:27  daveb
 * Removed FileDialog parameter.
 *
 * Revision 1.3  1996/01/04  14:21:54  matthew
 * Stuff
 *
 * Revision 1.2  1995/08/10  09:23:43  matthew
 * Making it all work
 *
 * Revision 1.1  1995/08/03  12:50:01  matthew
 * new unit
 * MS Windows GUI
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
 *)

require "../utils/__lists";
require "../basis/__word32";
require "../main/__version";
require "__menus";
require "__windows_gui";
require "__labelstrings";
require "__capitypes";

require "_capi";

structure Capi_ = 
  Capi (structure Lists = Lists_
        structure Menus = Menus_
        structure WindowsGui = WindowsGui
        structure LabelStrings = LabelStrings_
        structure CapiTypes = CapiTypes_
	structure Version = Version_
	structure Word32 = Word32
        )
