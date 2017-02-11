defmodule Statistics.Query.CheapestInRanges do
  alias Statistics.Query

  @firstPartitionMin 40
  @lastPartitionMax 90
  @partitionSize 5
  @maxCountPerRange 3

  def execute(cheapestQuery \\ Query.Cheapest, partition \\ Query.Partition) do
    for {min, max} <- partition.create(@firstPartitionMin, @lastPartitionMax, @partitionSize) do
      cheapestQuery.execute(@maxCountPerRange, min, max)
    end
  end
end
