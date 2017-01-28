defmodule Statistics.Query.PartitionTest do
  use ExUnit.Case
  alias Statistics.Query.Partition

  test "partition containing intervals of given range are returned" do

    assert Partition.create(47, 60, 5) == [{47, 52}, {52, 57}, {57, 60}]
  end

  test "partition consisting of only one interval is returned" do

    assert Partition.create(47, 49, 2) == [{47, 49}]
  end
end
