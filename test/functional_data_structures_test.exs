
# Based on the exercises in Chapter 3 of _Functional Programming in Scala_
defmodule FunctionalDataStructuresTest do
  use ExUnit.Case

  alias FunctionalDataStructures, as: L

  test "tail of empty list" do
    assert L.tail([]) == []
  end

  test "tail of normal list" do
    assert L.tail([1, 2, 3, 4]) == [2, 3, 4]
  end

  test "setHead of empty list" do
    assert L.setHead([], 5) == []
  end

  test "setHead of normal list should replace head of list" do
    assert L.setHead([1, 2, 3, 4], 5) == [5, 2, 3, 4]
  end

  test "drop of empty list" do
    assert L.drop([], 2) == []
  end

  test "drop of 0 elements should be same list" do
    assert L.drop([1, 2, 3], 0) == [1, 2, 3]
  end

  test "drop of normal list shold remove first n elements of the list" do
    assert L.drop([1, 2, 3, 4, 5], 2) == [3, 4, 5]
  end

  test "dropWhile removes elements from list while they match a predicate" do
    assert L.dropWhile([1, 2, 3, 4], &(&1 < 3)) == [3, 4]
  end

  test "initial returns a list will all elements except the last of a list" do
    assert L.initial([1, 2, 3, 4]) == [1, 2, 3]
  end
end
