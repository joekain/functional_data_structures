defmodule FunctionalDataStructures do
  def tail([]), do: []
  def tail([_h | t]), do: t

  def setHead([], _newHead), do: []
  def setHead([_h | t], newHead), do: [newHead | t]

  def drop([], 2), do: []
  def drop(l, 0), do: l
  def drop([_h | t], n), do: drop(t, n - 1)

  def dropWhile([], _f), do: []
  def dropWhile([h | t], f) do
    case f.(h) do
      true -> dropWhile(t, f)
      false -> [h | t]
    end
  end

  # This runs in time proportional to the lenght of the list
  # because the only way to find the end of the list is to traverse.
  def initial([]), do: []
  def initial([_h | []]), do: []
  def initial([h | t]), do: [h | initial(t)]

  def length(l), do: List.foldr(l, 0, fn (_x, acc) -> acc + 1 end)

  def foldLeft([], acc, _f), do: acc
  def foldLeft([h | t], acc, f), do: foldLeft(t, f.(h, acc), f)

  def sumLeft(l), do: foldLeft(l, 0, &(&1 + &2))
  def productLeft(l), do: foldLeft(l, 1, &(&1 * &2))
  def lengthLeft(l), do: foldLeft(l, 0, fn (_x, acc) -> acc + 1 end)

  def reverse(l), do: foldLeft(l, [], fn (x, acc) -> [x | acc] end)

  # The chain_accumulator passed into foldr is a function which means the
  # foldr produces a chain of functions.  For input [x, y, z] it
  # would produce:
  #   fn (b) -> f.z(f.y(f.x(b))) end
  # Then we evaluate this chain at the original acc value to get the final
  # result.
  def foldLeftUsingRight(l, acc, f) do
    base = fn (b) -> b end
    chain = List.foldr(l, base,
      fn (x, accumulator) -> (fn (b) -> accumulator.(f.(x, b)) end) end)
    chain.(acc)
  end

  def foldRightUsingLeft(l, acc, f), do: reverse(l) |> foldLeft(acc, f)

  def append(l, m), do: List.foldr(l, m, &([&1 | &2]))

  def concat([]), do: []
  def concat([head_list | tail]), do: append(head_list, concat(tail))

  def add_1([]), do: []
  def add_1([h | t]), do: [h + 1 | add_1(t)]

  def to_list_of_strings([]), do: []
  def to_list_of_strings([h | t]), do: [to_string(h) | to_list_of_strings(t)]

  # This was my first attempt, writing the direct recursive function.
  # This is not tail recursion.
  # def map([], f), do: []
  # def map([h | t], f), do: [f.(h) | map(t, f)]

  # Using foldr gives a more optimized solution
  def map(l, f), do: List.foldr(l, [], fn (x, acc) -> [f.(x) | acc] end)

  def filter([], _f), do: []
  def filter([h | t], f) do
    if f.(h) do
      [h | filter(t, f)]
    else
      filter(t, f)
    end
  end

  def flatMap(l, f), do: map(l, f) |> concat

  def filterUsingFlatMap(l, f), do: flatMap(l, fn (x) -> if f.(x), do: [x], else: [] end)

  defp zip([], _m), do: []
  defp zip(_l, []), do: []
  defp zip([lh | lt], [mh | mt]), do: [{lh, mh} | zip(lt, mt)]

  def sum_across_lists(l, m), do: zip(l, m) |> map(&( elem(&1, 0) + elem(&1, 1)))

  def across_lists(l, m, f), do: zip(l, m) |> map(&(f.(elem(&1, 0), elem(&1, 1))))

  def has_subsequence?([], []), do: true
  def has_subsequence?([], _sub), do: false
  def has_subsequence?([h | t], sub) do
    (zip([h | t], sub) |> List.foldl(true, &(&2 && elem(&1, 0) == elem(&1, 1)))) ||
      has_subsequence?(t, sub)
  end
end
