(*
 * Bar Chart Widget
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
 *  $Log: bar_chart.sml,v $
 *  Revision 1.2  1996/08/12 14:38:33  nickb
 *  Change behaviour of the selected bar.
 *  Note that some of this code is getting rather complex.
 *
 * Revision 1.1  1995/10/18  12:09:03  nickb
 * new unit
 * New bar chart widget.
 *
*)

signature BAR_CHART =
  sig
    type Widget

    datatype bar = Bar of
      {height: real,
       key: string,
       click_action: int -> unit}	(* argument is the bar number *)

      datatype chart_spec = ChartSpec of
	{maximum_bars : int,
	 bar_width : int,
	 maximum_tick_space : int,
	 ideal_label_space : int}

    val make : 
      chart_spec *
      (chart_spec -> unit) *		(* chart_spec changed by the user *)
      (unit -> (bar list * int)) *	(* the bars and the selected bar *)
      Widget ->
      {widget: Widget,
       initialize : unit -> unit,
       update: unit -> unit,
       popup: unit-> unit}
  end

