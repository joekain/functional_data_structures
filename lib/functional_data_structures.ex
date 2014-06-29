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
end
