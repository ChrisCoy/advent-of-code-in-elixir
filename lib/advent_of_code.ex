defmodule AdventOfCode do
  @moduledoc """
  Documentation for `AdventOfCode`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AdventOfCode.hello()
      :world

  """
  def hello do
    {:ok, files} = File.ls()

    files |> Enum.each(&IO.inspect/1)
  end
end
