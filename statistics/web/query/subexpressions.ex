defmodule Statistics.Query.Subexpressions do
  import Ecto.Query

  alias Statistics.Property

  def selectProperties(maxCount) do
    from property in Property,
      limit: ^maxCount,
      select: property
  end

  def setMinSquareMetresCondition(query, minSquareMetresExclusive) do
    case minSquareMetresExclusive do
      nil -> query
      _ -> query |> where([property], ^minSquareMetresExclusive < property.squareMetres)
    end
  end

  def setMaxSquareMetresCondition(query, maxSquareMetresInclusive) do
    case maxSquareMetresInclusive do
      nil -> query
      _ -> query |> where([property], property.squareMetres <= ^maxSquareMetresInclusive)
    end
  end
end
