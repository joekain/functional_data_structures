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
  def initial([h | []]), do: []
  def initial([h | t]), do: [h | initial(t)]
end
