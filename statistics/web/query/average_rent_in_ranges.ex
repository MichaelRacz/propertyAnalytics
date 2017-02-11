defmodule Statistics.Query.AverageRentInRanges do
  alias Statistics.Query

  @firstPartitionMin 40
  @lastPartitionMax 90
  @partitionSize 5

  def execute(averageRentQuery \\ Query.AverageRent, partition \\ Query.Partition) do
    for {min, max} <- partition.create(@firstPartitionMin, @lastPartitionMax, @partitionSize) do
      averageRentQuery.execute(min, max)
    end
  end
end
