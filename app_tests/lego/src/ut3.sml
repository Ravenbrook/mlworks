(*
 *
 * $Log: ut3.sml,v $
 * Revision 1.2  1998/08/05 17:35:52  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
signature POS =
  sig
    type pos
    val lno : pos ref
    val init_lno : unit->unit
    val inc_lno : unit->unit
    val errmsg : string->(string*pos*pos)->unit
  end;
