defmodule Statistics.Query.TestPartition do
  import ExUnit.Assertions

  @behaviour Statistics.Query.Behaviour.Partition

  @range1 {40, 45}
  @range2 {85, 90}

  def range1, do: @range1
  def range2, do: @range2

  def create(min, max, step) do
    assert min == 40
    assert max == 90
    assert step == 5

    [@range1, @range2]
  end
end
