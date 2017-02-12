defmodule Statistics.QueryController do
  use Statistics.Web, :controller

  alias Statistics.Query

  def averageRentInRanges(conn, _params) do
    result = for {range, averageRent} <- Query.AverageRentInRanges.execute do
      %{range: mapRange(range), averageRent: averageRent}
    end

    json conn, %{result: result}
  end

  def averageRent(conn, %{"minSquareMetresExclusive" => min, "maxSquareMetresInclusive" => max}) do
    averageRent = Query.AverageRent.execute(min, max)

    json conn, %{result: %{averageRent: averageRent}}
  end

  def cheapestInRanges(conn, _params) do
    result = for {range, properties} <- Query.CheapestInRanges.execute do
      %{range: mapRange(range), cheapest: mapProperties(properties)}
    end

    json conn, %{result: result}
  end

  def cheapest(conn, %{"maxCount" => count, "minSquareMetresExclusive" => min, "maxSquareMetresInclusive" => max}) do
    cheapestProperties = Query.Cheapest.execute(count, min, max)
    result = mapProperties(cheapestProperties)

    json conn, %{result: result}
  end

  def priciest(conn,  %{"maxCount" => count, "minSquareMetresExclusive" => min, "maxSquareMetresInclusive" => max}) do
    priciestProperties = Query.Priciest.execute(count, min, max)
    result = mapProperties(priciestProperties)

    json conn, %{result: result}
  end

  def rentPerSquareMetre(conn, %{"maxCount" => count}) do
    result = for {property, rentPerSquareMetre} <- Query.RentPerSquareMetre.execute(count) do
      %{property: mapProperty(property), rentPerSquareMetre: rentPerSquareMetre}
    end

    json conn, %{result: result}
  end

  defp mapRange(range) do
    {min, max} = range
    %{min: min, max: max}
  end

  defp mapProperties(properties) do
    for property <- properties do
      mapProperty(property)
    end
  end

  defp mapProperty(property) do
    %{description: property.description, rent: property.rent, squareMetres: property.squareMetres}
  end
end
