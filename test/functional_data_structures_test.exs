
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

  test "length computes the length of a list" do
    assert L.length([1, 2, 3, 4]) == 4
  end

  test "foldLeft of a normal list" do
    assert L.foldLeft([1, 2, 3, 4], 0, &(&1 + &2)) == 10
  end

  test "sum using foldLeft" do
    assert L.sumLeft([1, 2, 3, 4]) == 10
  end

  test "product using foldLeft" do
    assert L.productLeft([1, 2, 3, 4]) == 24
  end

  test "length using foldLeft" do
    assert L.lengthLeft([1, 2, 3, 4]) == 4
  end

  test "reverse a list" do
    assert L.reverse([1, 2, 3, 4]) == [4, 3, 2, 1]
  end

  test "foldLeft written using foldRight" do
    assert L.foldLeftUsingRight([1, 2, 3, 4], 0, &(&1 - &2)) == List.foldl([1, 2, 3, 4], 0, &(&1 - &2))
  end

  test "foldRight written using foldLeft" do
    assert L.foldRightUsingLeft([1, 2, 3, 4], 0, &(&1 - &2)) == List.foldr([1, 2, 3, 4], 0, &(&1 - &2))
  end

  test "append" do
    assert L.append([1, 2, 3, 4], [8, 9, 10]) == [1, 2, 3, 4, 8, 9, 10]
  end

  test "concat list of lists into a single list" do
    assert L.concat([[1,2],[3],[],[4,5,6]]) == [1,2,3,4,5,6]
  end
end
