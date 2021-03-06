defmodule Statistics.Query.Priciest do
  import Statistics.Query.Subexpressions
  import Ecto.Query

  def execute(maxCount \\ 1, minSquareMetresExclusive \\ nil, maxSquareMetresInclusive \\ nil) do
    selectProperties(maxCount)
      |> orderByRentDescending
      |> setMinSquareMetresCondition(minSquareMetresExclusive)
      |> setMaxSquareMetresCondition(maxSquareMetresInclusive)
      |> Statistics.Repo.all
  end

  defp orderByRentDescending(query) do
    query |> order_by([property], [desc: property.rent])
  end
end
