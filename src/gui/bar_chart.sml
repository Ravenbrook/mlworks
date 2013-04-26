(*
 * Bar Chart Widget
 *
 * Copyright (c) 1995 Harlequin Ltd.
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

