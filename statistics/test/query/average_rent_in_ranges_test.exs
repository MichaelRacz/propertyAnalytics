defmodule Statistics.Query.AverageRentInRangesTest do
  use ExUnit.Case

  alias Statistics.Query.AverageRentInRanges
  alias Statistics.Query.TestPartition

  defmodule TestAverageRent do
    alias Statistics.Query.TestPartition

    @behaviour Statistics.Query.Behaviour.AverageRent

    @resultOfRange1 :result1
    @resultOfRange2 :result2

    def resultOfRange1, do: @resultOfRange1
    def resultOfRange2, do: @resultOfRange2

    def execute(minSquareMetresExclusive, maxSquareMetresInclusive) do
      range1 = TestPartition.range1
      range2 = TestPartition.range2

      case {minSquareMetresExclusive, maxSquareMetresInclusive} do
        ^range1 -> @resultOfRange1
        ^range2 -> @resultOfRange2
      end
    end
  end

  test "average rent of ranges are concatenated" do
    result = AverageRentInRanges.execute(TestAverageRent, TestPartition)

    range1 = TestPartition.range1
    range2 = TestPartition.range2

    assert result == [{range1, TestAverageRent.resultOfRange1},
      {range2, TestAverageRent.resultOfRange2}]
  end
end
