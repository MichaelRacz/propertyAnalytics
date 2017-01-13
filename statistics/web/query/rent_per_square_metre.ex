defmodule Statistics.Query.RentPerSquareMetre do
  import Statistics.Query.Subexpressions
  import Ecto.Query

  def execute(maxCount \\ 1) do
    properties = selectProperties(maxCount)
      |> orderByRentPerSquareMetre
      |> Statistics.Repo.all

    Enum.map(properties, &createResult/1)
  end

  defp orderByRentPerSquareMetre(query) do
    query |> order_by([property], [asc: fragment("rent / \"squareMetres\"")])
  end

  defp createResult(property) do
    rentPerSquareMetre = property.rent / property.squareMetres
    {property, rentPerSquareMetre}
  end
end
