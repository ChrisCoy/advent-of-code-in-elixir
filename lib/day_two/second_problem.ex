defmodule AdventOfCode.DayTwo.SecondProblem do
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
    |> IO.inspect()

    # |> get_valid_games()
    # |> Enum.sum()
  end

  def is_valid_game(line) do
    cubes = %{}

    [_id, plays] = String.split(line, ":", trim: true)

    line
    |> String.split(";", trim: true)
    |> Enum.map(fn play ->
      pieces = String.split(play, ",", trim: true)
      pieces
    end)
  end

  defp read_file do
    File.stream!("assets/day_two/sample.txt")
    |> Enum.map(fn line ->
      line
      |> String.trim()
    end)
  end
end
