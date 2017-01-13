defmodule Statistics.Query.Priciest do
  import Statistics.Query.Subexpressions
  import Ecto.Query

  def execute(maxCount \\ 1, minRentExclusive \\ nil, maxRentInclusive \\ nil) do
    selectProperties(maxCount)
      |> orderByRentDescending
      |> setMinRentCondition(minRentExclusive)
      |> setMaxRentCondition(maxRentInclusive)
      |> Statistics.Repo.all
  end

  defp orderByRentDescending(query) do
    query |> order_by([property], [desc: property.rent])
  end
end
