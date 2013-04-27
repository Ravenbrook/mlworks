/*  === LICENSING ===
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  Centralised location for version information in runtime 
 *
 *  $Log: version.h,v $
 *  Revision 1.3  1999/03/09 15:55:16  mitchell
 *  [Bug #190509]
 *  Update version strings to 2.1
 *
 * Revision 1.2  1998/07/30  15:03:33  jkbrook
 * [Bug #30456]
 * Update for 2.0c0
 *
 * Revision 1.1  1998/06/11  19:11:58  jkbrook
 * new unit
 * Start to centralise version information
 *
 *
 */

/* 
   This is currently used to differentiate stored licence files and
   registry entries.  If version is full, then candidate numbers should
   be ignored as licences will need to be reinstalled too often.

   The problem of specifying these things explicitly will disappear 
   when this file represents version info in a simliarly structured 
   way to main/__version.sml.
*/

#define VERSION_STR "2.1"

#define MAJOR_VERSION 2.1

