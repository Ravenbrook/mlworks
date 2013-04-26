(*

Result: OK
 
$Log: bytearray_initialise.sml,v $
Revision 1.3  1998/02/18 11:55:59  mitchell
[Bug #30349]
Fix test to avoid non-unit sequence warning

 * Revision 1.2  1996/09/11  14:32:15  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.1  1994/08/16  09:46:51  jont
 * new file
 *
Copyright (c) 1994 Harlequin Ltd.
*)
local
  open MLWorks.Internal.ByteArray
in
  fun foo n = (ignore(array(n,1));
	       if n < 10000 then foo(n+1) else n)
  val x = foo 0
end
