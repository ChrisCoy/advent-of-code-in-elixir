defmodule AdventOfCode.Day4.SecondProblem do
  @todo "try to implement using monads"

  def call do
    solution()
  end

  def solution do
    lines = read_file()
    width = String.length(Enum.at(lines, 0))
    text = Enum.join(lines)

    coordinates = [
      {:top, -width},
      {:top_right, -width + 1},
      {:right, 1},
      {:bottom_right, width + 1},
      {:bottom, width},
      {:bottom_left, width - 1},
      {:left, -1},
      {:top_left, -width - 1}
    ]

    get_numbers(text, coordinates)
    |> List.flatten()
    |> Enum.sum()
  end

  defp get_numbers(text, coords) do
    text
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.reduce([], fn {el, i}, acc ->
      is_symbol = is_symbol(el)

      if is_symbol do
        [{el, i} | acc]
      else
        acc
      end
    end)
    |> Enum.reduce(%{visites: MapSet.new(), numbers: []}, fn {el, i}, acc ->
      old_visites = Map.get(acc, :visites)
      old_numbers = Map.get(acc, :numbers)

      with true <- el == "*",
           {visites, numbers} <- find_numbers(text, {el, i}, coords, [], old_visites),
           true <- length(numbers) > 1 do
        %{visites: visites, numbers: [Enum.product(numbers) | old_numbers]}
      else
        _ -> acc
      end
    end)
    |> Map.get(:numbers)
  end

  defp find_numbers(_text, _el, [], acc, visites), do: {visites, acc}

  defp find_numbers(text, {el, i}, [h | t] = _cords, acc, visites) do
    cord = i + elem(h, 1)
    not_visited = MapSet.filter(visites, fn c -> c == cord end) |> MapSet.size() == 0
    char = String.at(text, cord)

    new_set = MapSet.put(visites, cord)

    with true <- cord >= 0,
         true <- char != nil,
         true <- is_string_number(char),
         true <- not_visited do
      {visited_pos, number} = get_neighbor_number(text, cord)

      find_numbers(text, {el, i}, t, [number | acc], MapSet.union(new_set, visited_pos))
    else
      _ ->
        find_numbers(text, {el, i}, t, acc, new_set)
    end
  end

  defp get_neighbor_number(text, i) do
    char = String.at(text, i)

    {visited_pos_left, left_chars} = get_neighbor_left(text, i - 1)
    {visited_pos_right, right_chars} = get_neighbor_right(text, i + 1)

    visites = MapSet.put(visited_pos_left, i) |> MapSet.union(visited_pos_right)

    {visites, String.to_integer(left_chars <> char <> right_chars)}
  end

  defp get_neighbor_left(text, i, acc \\ "", visites \\ MapSet.new()) do
    char = String.at(text, i)
    new_set = MapSet.put(visites, i)

    if is_string_number(char) do
      get_neighbor_left(text, i - 1, char <> acc, new_set)
    else
      {new_set, acc}
    end
  end

  defp get_neighbor_right(text, i, acc \\ "", visites \\ MapSet.new()) do
    char = String.at(text, i)
    new_set = MapSet.put(visites, i)

    if is_string_number(char) do
      get_neighbor_right(text, i + 1, acc <> char, new_set)
    else
      {new_set, acc}
    end
  end

  defp is_string_number(char) do
    String.contains?("0123456789", char)
  end

  defp is_symbol(char) do
    not String.contains?("0123456789.", char)
  end

  defp read_file do
    File.stream!("assets/day_3/input.txt")
    |> Enum.map(fn line ->
      line
      |> String.replace("\n", ".")
    end)
  end
end
