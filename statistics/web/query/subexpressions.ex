defmodule Statistics.Query.Subexpressions do
  import Ecto.Query

  alias Statistics.Property

  def selectProperties(maxCount) do
    from property in Property,
      limit: ^maxCount,
      select: property
  end

  def setMinRentCondition(query, minRentExclusive) do
    case minRentExclusive do
      nil -> query
      _ -> query |> where([property], ^minRentExclusive < property.rent)
    end
  end

  def setMaxRentCondition(query, maxRentInclusive) do
    case maxRentInclusive do
      nil -> query
      _ -> query |> where([property], property.rent <= ^maxRentInclusive)
    end
  end
end
