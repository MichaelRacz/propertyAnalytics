defmodule Statistics.Query.CheapestInRangesTest do
  use ExUnit.Case

  alias Statistics.Query.CheapestInRanges
  alias Statistics.Query.TestPartition

  setup do
    Code.require_file("test/query/test_partition.exs")
  end

  defmodule TestCheapest do
    alias Statistics.Query.TestPartition

    @behaviour Statistics.Query.Behaviour.Cheapest

    @resultOfRange1 :result1
    @resultOfRange2 :result2

    def resultOfRange1, do: @resultOfRange1
    def resultOfRange2, do: @resultOfRange2

    def execute(maxCount, minSquareMetresExclusive, maxSquareMetresInclusive) do
      assert maxCount == 3

      range1 = TestPartition.range1
      range2 = TestPartition.range2

      case {minSquareMetresExclusive, maxSquareMetresInclusive} do
        ^range1 -> @resultOfRange1
        ^range2 -> @resultOfRange2
      end
    end
  end

  test "cheapest properties of ranges are concatenated" do
    result = CheapestInRanges.execute(TestCheapest, TestPartition)

    assert result == [TestCheapest.resultOfRange1, TestCheapest.resultOfRange2]
  end
end
