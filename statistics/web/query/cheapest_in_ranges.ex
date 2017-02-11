defmodule Statistics.Query.CheapestInRanges do
  alias Statistics.Query

  @firstPartitionMin 40
  @lastPartitionMax 90
  @partitionSize 5
  @maxCountPerRange 3

  def execute(cheapestQuery \\ Query.Cheapest, partition \\ Query.Partition) do
    for partition = {min, max} <- partition.create(@firstPartitionMin, @lastPartitionMax, @partitionSize) do
      {partition, cheapestQuery.execute(@maxCountPerRange, min, max)}
    end
  end
end
