defmodule Statistics.Query.Cheapest do
  import Statistics.Query.Subexpressions
  import Ecto.Query

  def execute(maxCount \\ 1, minRentExclusive \\ nil, maxRentInclusive \\ nil) do
    selectProperties(maxCount)
      |> orderByRentAscending
      |> setMinRentCondition(minRentExclusive)
      |> setMaxRentCondition(maxRentInclusive)
      |> Statistics.Repo.all
  end

  defp orderByRentAscending(query) do
    query |> order_by([property], [asc: property.rent])
  end
end
