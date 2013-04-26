use "utils/benchmark";

structure CurryTak =
  struct
    local
      fun tak x y z = 
        if x <= y 
          then z
        else tak (tak (x-1) y z) (tak(y-1) z x) (tak(z-1) x y)
    in
      fun curry_tak_test() =
        tak 18 12 6
    end
  end

test "curry tak" 500 CurryTak.curry_tak_test ()
