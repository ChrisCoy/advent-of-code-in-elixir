defmodule AdventOfCode.DayOne.Solution do
  def call do
    parse_input_to_array()
  end

  defp parse_input_to_array do
    File.stream!("assets/day_one/input.txt")
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> find_values_on_line()
    end)
    # |> Enum.each(&IO.inspect/1)

    |> Enum.sum()
  end

  defp find_values_on_line(line) do
    result = String.split(line, ~r/[^\d]/) |> Enum.filter(fn chars -> chars != "" end)

    case result do
      [] ->
        0

      [x] ->
        String.to_integer(x)

      list ->
        first = List.first(list)
        last = List.last(list)

        String.to_integer("#{first}#{last}")
    end

    # IO.inspect(result)

    # number = "#{first}#{last}"

    # # case number do
    # #   "" ->
    # #     0

    # #   _ ->
    # #     String.to_integer(number)
    # # end
  end

  # defp char_value(charlists), do: Enum.map(charlists, fn char -> char - 98 end)
end
