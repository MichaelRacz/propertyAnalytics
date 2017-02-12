defmodule Statistics.Query.CheapestInRanges do
  alias Statistics.Query

  @firstPartitionMin 40
  @lastPartitionMax 90
  @partitionSize 5
  @maxCountPerRange 3

  def execute(cheapestQuery \\ Query.Cheapest, partition \\ Query.Partition) do
    # Execute queries parallel to try out async/await. Would have more impact if db is mirrored.
    tasks = for partition = {min, max} <- partition.create(@firstPartitionMin, @lastPartitionMax, @partitionSize) do
      Task.async(fn -> {partition, cheapestQuery.execute(@maxCountPerRange, min, max)} end)
    end

    for task <- tasks do
      Task.await(task)
    end
  end
end
