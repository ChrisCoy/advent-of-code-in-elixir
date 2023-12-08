defmodule AdventOfCode.Day1.SecondProblem do
  @numbers %{
    "1" => "1",
    "2" => "2",
    "3" => "3",
    "4" => "4",
    "5" => "5",
    "6" => "6",
    "7" => "7",
    "8" => "8",
    "9" => "9",
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  def call do
    get_sum()
  end

  defp get_sum do
    File.stream!("assets/day_1/input.txt")
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> find_values_on_line()
    end)
    |> Enum.sum()
  end

  defp find_values_on_line(line) do
    numbers_on_line = get_numbers(line)

    case numbers_on_line do
      [] ->
        0

      [head] ->
        first = @numbers[head]

        String.to_integer("#{first}#{first}")

      list ->
        first = @numbers[List.first(list)]
        last = @numbers[List.last(list)]

        String.to_integer("#{first}#{last}")
    end
  end

  #
  #
  defp get_numbers("", acc), do: acc
  #
  defp get_numbers(line, acc \\ []) do
    only_numbers_regex = ~r/one|two|three|four|five|six|seven|eight|nine|\d/

    characters =
      Regex.scan(only_numbers_regex, line, flat: true) |> List.flatten()

    case characters do
      [] -> acc
      [head] -> get_numbers(String.slice(line, 1..-1), acc ++ [head])
      [head | _tail] -> get_numbers(String.slice(line, 1..-1), acc ++ [head])
    end
  end
end
