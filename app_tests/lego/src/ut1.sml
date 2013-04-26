(*
 *
 * $Log: ut1.sml,v $
 * Revision 1.2  1998/08/05 17:12:49  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "$.basis.__list";
require "$.unix.__unixos";
require "$.basis.__string";
require "$.basis.__char";
require "$.basis.__text_io";

(*fun print s = output (std_out, s);*)
fun print_bool b = print (if b then "true" else "false");
fun int_to_string n =
  let
    fun makeDigit digit =
      if digit >= 10 then chr (ord #"A" + digit - 10)
      else chr (ord #"0" + digit)
    val sign = if n < 0 then "~" else ""
    fun makeDigits (n,acc) =
      let
        val digit = 
          if n >= 0 
            then n mod 10
          else 
            let
              val res = n mod 10
            in
              if res = 0 then 0 else 10 - res
            end
        val n' = 
          if n >= 0 orelse digit = 0 then 
            n div 10
          else 1 + n div 10
        val acc' = makeDigit digit :: acc
        in 
          if n' <> 0
            then makeDigits (n',acc')
          else acc'
      end
  in
    sign^(implode (makeDigits (n,[])))
  end
val substring = MLWorks.String.substring;
val get_unix_environment = UnixOS_.environment;
datatype 'a option = SOME of 'a | NONE;
fun inc x = x := !x + 1;
val ordof = Char.ord o String.sub
val setwd = UnixOS_.FileSys.chdir;
val getwd = UnixOS_.FileSys.getcwd;
val flush_out = TextIO.flushOut;
val input_line = TextIO.inputLine;
