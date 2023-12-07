defmodule AdventOfCode.DayThree.FirstProblem do
  @rules %{
    "red" => 12,
    "blue" => 14,
    "green" => 13
  }

  def call do
    solution()
  end

  def solution do
    read_file()
    |> Enum.filter(&is_valid_game/1)
    |> Enum.map(&get_id_from_line/1)
    |> Enum.sum()
  end

  def is_valid_game(line) do
    [_id, plays] = String.split(line, ":")

    plays
    |> String.split(";")
    |> Enum.map(fn play ->
      pieces = String.split(play, ",") |> Enum.map(&String.trim/1)

      Enum.all?(pieces, fn piece ->
        [qntd, key] = String.split(piece, " ")

        String.to_integer(qntd) <= @rules[key]
      end)
    end)
    |> Enum.all?()
  end

  defp get_id_from_line(line) do
    [_head, id | _tail] = String.split(line, ~r/[ :]/)
    String.to_integer(id)
  end

  defp read_file do
    File.stream!("assets/day_two/input.txt")
    |> Enum.map(fn line ->
      line
      |> String.trim()
    end)
  end
end
