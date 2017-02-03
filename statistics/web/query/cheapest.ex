defmodule Statistics.Query.Cheapest do
  import Statistics.Query.Subexpressions
  import Ecto.Query

  @behaviour Statistics.Query.Behaviour.Cheapest

  def execute(maxCount \\ 1, minSquareMetresExclusive \\ nil, maxSquareMetresInclusive \\ nil) do
    selectProperties(maxCount)
      |> orderByRentAscending
      |> setMinSquareMetresCondition(minSquareMetresExclusive)
      |> setMaxSquareMetresCondition(maxSquareMetresInclusive)
      |> Statistics.Repo.all
  end

  defp orderByRentAscending(query) do
    query |> order_by([property], [asc: property.rent])
  end
end
