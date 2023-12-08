defmodule AdventOfCode.Day3.FirstProblem do
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
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
    |> IO.inspect(label: "first_problem:")
  end

  defp get_numbers(text, coords) do
    text
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{list: [], word_acc: nil, valid: false}, fn {el, i}, acc ->
      is_string_number = is_string_number(el)
      %{list: list, word_acc: word_acc, valid: valid} = acc

      cond do
        is_string_number ->
          is_valid = theres_adjacent_symbol(text, i, coords)
          Map.merge(acc, %{word_acc: "#{word_acc}#{el}", valid: valid || is_valid})

        valid ->
          Map.merge(acc, %{list: list ++ [word_acc], word_acc: nil, valid: false})

        true ->
          Map.merge(acc, %{word_acc: nil, valid: false})
      end
    end)
    |> Map.get(:list)
  end

  defp theres_adjacent_symbol(_text, _index, []), do: false

  defp theres_adjacent_symbol(text, index, [cord | t] = _cords) do
    position = index + elem(cord, 1)

    with true <- position >= 0,
         char <- String.at(text, position),
         true <- char != nil,
         true <- is_symbol(char) do
      true
    else
      _ -> theres_adjacent_symbol(text, index, t)
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
