(*
Check that we can handle exceptions raised from c correctly

Result: OK
 
$Log: handler_c_raise.sml,v $
Revision 1.7  1998/02/18 11:56:00  mitchell
[Bug #30349]
Fix test to avoid non-unit sequence warning

 * Revision 1.6  1997/11/21  10:54:56  daveb
 * [Bug #30323]
 *
 * Revision 1.5  1997/07/15  15:50:11  daveb
 * [Bug #30200]
 * Made the handler allocate a large list, to check that the in_ML flag
 * is being set correctly.
 *
 * Revision 1.4  1997/05/28  16:40:12  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.3  1996/05/31  12:36:57  jont
 * Io has moved into MLWorks.IO
 *
 * Revision 1.2  1996/05/01  17:37:25  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/08/17  12:01:28  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)


fun long_list (a,0) = a
  | long_list (a,n) = long_list (n::a, n-1);

val _ =
  (ignore(TextIO.openIn"pooooo"); [])
  handle IO.Io _ =>
    long_list ([], 1000000);
