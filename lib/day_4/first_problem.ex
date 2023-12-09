defmodule AdventOfCode.Day4.FirstProblem do
  def call do
    solution()
  end

  def solution do
    file_stream = read_file()

    file_stream
    |> Stream.map(&get_numbers/1)
    |> Stream.map(&calc_points/1)
    |> Enum.sum()
  end

  defp calc_points(game) do
    %{winners: winners, plays: plays} = game

    wins_count =
      Enum.reduce(plays, 0, fn number, acc ->
        contains = Enum.find(winners, &(&1 == number))

        if contains, do: acc + 1, else: acc
      end)

    if wins_count > 0 do
      Integer.pow(2, wins_count - 1)
    else
      0
    end
  end

  defp get_numbers(line) do
    [winners, plays] =
      line
      |> String.replace(~r/Card \d: +/, "")
      |> String.split("|")
      |> Enum.map(&String.split(&1, " ", trim: true))

    %{winners: winners, plays: plays}
  end

  defp read_file do
    File.stream!("assets/day_4/input.txt")
    |> Stream.map(&String.trim/1)
  end
end
