defmodule AdventOfCode.DayOne.Solution do
  def call do
    parse_input_to_array()
  end

  defp parse_input_to_array do
    File.stream!("assets/day_one/input.txt")
    |> Enum.map(fn line ->
      line |> String.trim() |> String.to_charlist() |> Enum.sum()
    end)
    |> Enum.sum()
  end
end
