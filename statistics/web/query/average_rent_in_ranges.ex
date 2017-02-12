defmodule Statistics.Query.AverageRentInRanges do
  alias Statistics.Query

  @firstPartitionMin 40
  @lastPartitionMax 90
  @partitionSize 5

  def execute(averageRentQuery \\ Query.AverageRent, partition \\ Query.Partition) do
    # Execute queries parallel to try out async/await. Would have more impact if db is mirrored.
    tasks = for partition = {min, max} <- partition.create(@firstPartitionMin, @lastPartitionMax, @partitionSize) do
      Task.async(fn -> {partition, averageRentQuery.execute(min, max)} end)
    end

    for task <- tasks do
      Task.await(task)
    end
  end
end
