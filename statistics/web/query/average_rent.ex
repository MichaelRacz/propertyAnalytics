defmodule Statistics.Query.AverageRent do
  import Statistics.Query.Subexpressions
  import Ecto.Query

  alias Statistics.Property

  @behaviour Statistics.Query.Behaviour.AverageRent

  def execute(minSquareMetresExclusive \\ nil, maxSquareMetresInclusive \\ nil) do
    query = (from property in Property,
      select: avg(property.rent))
      |> setMinSquareMetresCondition(minSquareMetresExclusive)
      |> setMaxSquareMetresCondition(maxSquareMetresInclusive)

    [average] = Statistics.Repo.all (query)
    average
  end
end
