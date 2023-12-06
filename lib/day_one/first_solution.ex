defmodule AdventOfCode.DayOne.FirstSolution do
  def call do
    get_sum()
  end

  defp get_sum do
    File.stream!("assets/day_one/input.txt")
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> find_values_on_line()
    end)
    |> Enum.sum()
  end

  defp find_values_on_line(line) do
    result =
      String.split(line, "")
      |> Enum.filter(fn char ->
        case Integer.parse(char) do
          :error -> false
          _ -> true
        end
      end)

    case result do
      [] ->
        0

      [x] ->
        number = String.to_integer(x)
        String.to_integer("#{number}#{number}")

      list ->
        first = List.first(list)
        last = List.last(list)

        String.to_integer("#{first}#{last}")
    end

  end
end
