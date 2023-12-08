defmodule AdventOfCode.Day2.SecondProblem do
  def call do
    solution()
  end

  def solution do
    read_file()
    |> Enum.map(&get_min_of_pieces/1)
    |> Enum.sum()
  end

  def get_min_of_pieces(line) do
    [_id, plays] = String.split(line, ":")

    plays
    |> String.split(";")
    |> Enum.map(&String.split(&1, ","))
    |> List.flatten()
    |> Enum.map(&String.trim/1)
    |> Enum.reduce(%{}, fn piece, acc ->
      [qntd, color] = String.split(piece, " ")
      quantity_int = String.to_integer(qntd)

      Map.update(acc, color, quantity_int, fn value ->
        if quantity_int > value do
          quantity_int
        else
          value
        end
      end)
    end)
    |> Map.values()
    |> Enum.filter(&(&1 != 0))
    |> Enum.product()
  end

  defp read_file do
    File.stream!("assets/day_2/input.txt")
    |> Enum.map(fn line ->
      line
      |> String.trim()
    end)
  end
end
