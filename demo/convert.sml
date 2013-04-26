require "church";
require "integer_demo";

fun ChurchToInteger c =
  Church.reduce Integer.successor Integer.zero c

fun IntegerToChurch i =
  Integer.reduce Church.successor Church.zero i
