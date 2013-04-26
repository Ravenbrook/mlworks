(*

Result: OK
 
$Log: profile3.sml,v $
Revision 1.6  1996/11/05 14:40:37  jont
Change reasonableness test to cope with faster machines

 * Revision 1.5  1996/11/01  11:40:37  io
 * [Bug #1614]
 * remove toplevel String.
 *
 * Revision 1.4  1996/05/01  17:18:00  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.3  1996/04/19  16:28:25  nickb
 * Change profile test so it is not sensitive to the presence of tail-calling.
 *
 * Revision 1.2  1995/08/21  15:54:09  nickb
 * Update to new profiler.
 *
Revision 1.2  1995/08/21  15:09:42  nickb
Update to new profiler.

Revision 1.1  1993/06/22  16:03:50  jont
Initial revision

Revision 1.1  1993/06/22  15:34:33  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

(* test that results of time- and space-profiling 'fibl' are reasonable *)

local
(* stuff to run the profile *)

  val manner = MLWorks.Profile.make_manner
    {time = true,
     space = true,
     calls = false,
     copies = false,
     depth = 0,
     breakdown = []}
  val null_manner = MLWorks.Profile.make_manner
    {time = false,
     space = false,
     calls = false,
     copies = false,
     depth = 0,
     breakdown = []}

  fun is_my_test s =
    MLWorks.String.ordof (s,0) = ord #"m"
    andalso MLWorks.String.ordof (s,1) = ord #"y"
    andalso MLWorks.String.ordof (s,2) = ord #"_"
    andalso MLWorks.String.ordof (s,3) = ord #"t"
    andalso MLWorks.String.ordof (s,4) = ord #"e"
    andalso MLWorks.String.ordof (s,5) = ord #"s"
    andalso MLWorks.String.ordof (s,6) = ord #"t"
    
  fun selector s = if is_my_test s then manner else null_manner

  val options = MLWorks.Profile.Options {scan = 10, selector = selector}

(* stuff to extract totals out of the profile *)

  fun get_top_scans (MLWorks.Profile.Function_Time_Profile {top,...}) = top

  fun real_data (MLWorks.Profile.Large_Size {bytes,megabytes}) =
		 (real megabytes)*1048576.0+(real bytes)

  fun get_allocated (MLWorks.Profile.Function_Space_Profile{allocated,...}) =
		 real_data allocated

  fun matching pred (total as (totalscans,totaldata),
		     MLWorks.Profile.Function_Profile
		     {id, time,space,...}) =
    if pred id then (totalscans + (get_top_scans time),
		     totaldata + (get_allocated space))
    else total

  fun fold f z [] = z
    | fold f z (x::xs) = fold f (f(z,x)) xs

  local
    fun length' (a,[]) = a | length' (a,x::xs) = length'(a+1,xs)
  in
    fun length l = length'(0,l)
  end

(* a function to profile *)

  fun my_test_rev_app (x::xs, ys) = my_test_rev_app(xs,x::ys)
    | my_test_rev_app ([]   , ys) = ys

  fun my_test_fibl 0 = [0]
    | my_test_fibl 1 = [0]
    | my_test_fibl n = my_test_rev_app(my_test_fibl (n-1),my_test_fibl (n-2))

(* now profile it *)

  val (result,profile) = MLWorks.Profile.profile options my_test_fibl 27

(* get the results *)

  val MLWorks.Profile.Profile {time = MLWorks.Profile.Time time_header,
			       space = MLWorks.Profile.Space space_header,
			       functions,...} = profile
  val {scans = total_scans,...} = time_header
  val {total_profiled = MLWorks.Profile.Function_Space_Profile {allocated,...},
       ...} = space_header
  val total_data = real_data allocated
  val (my_test_scans,my_test_data) = fold (matching is_my_test) (0,0.0) functions

in

(* check the results *)
   val it =
     if my_test_scans < 0 then
       "Nonsense profiling result for my_fibl 27 : my_test_scans < 0"
     else if total_scans < 0 then
       "Nonsense profiling result for my_fibl 27 : total_scans < 0"
     else if my_test_scans > total_scans then
       "Nonsense profiling result for my_fibl 27 : my_test_scans > total_scans"
     else if total_scans < 50 (* 0.5 seconds, in theory *) then 
       "Unexpected profiling result for my_fibl 27 : fewer than 50 scans"
     else if my_test_scans < floor ((real total_scans) * 0.8) then
       "Unexpected result for my_fibl 27 : less than 80% time spent in 'my_test_...'"
     else if my_test_data < 0.0 then
        "Nonsense profiling result for my_fibl 27 : my_test_data < 0.0"
     else if total_data < 0.0 then
       "Nonsense profiling result for my_fibl 27 : total_data < 0.0"
     else if my_test_data > total_data then
       "Nonsense profiling result for my_fibl 27 : my_test_data > total_data"
     else if length functions > 10 then
       "Unexpected profiling result for my_fibl 27 : more than 10 'my_test_...' fns"
     else if total_data < 25.0*1048576.0 then
       "Unexpected profiling result for my_fibl 27 : less than 25Mb allocated"
     else if my_test_data < (total_data * 0.99) then
       "Unexpected result for my_fibl 27 : less than 99% data made by 'my_test_...'"
     else "Profiling my_fibl 27 has a reasonable result"
end
