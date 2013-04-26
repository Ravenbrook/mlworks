(*
 *
 * $Log: link-sys.sml,v $
 * Revision 1.2  1998/06/03 11:49:33  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
structure Hasher : HASHER = Hasher ();
structure Sys : SYS = NewJersey ();
structure Time : TIME = Time ();

structure Location : LOCATION = Location (structure Sys = Sys);
