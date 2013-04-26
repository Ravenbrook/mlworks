fun front [] = []
|   front [_ : int] = []
|   front (h :: l) =
  let val r = front l
  in h :: r
  end
