defmodule Statistics.QueryControllerTest do
  use Statistics.ConnCase

  alias Statistics.Property

  @epsilon 0.1

  setup do
    propertyFields = [%{description: "a", rent: "10.0", squareMetres: "60.2"},
      %{description: "b", rent: "15.0", squareMetres: "61.5"},
      %{description: "c", rent: "30.0", squareMetres: "85.5"},
      %{description: "d", rent: "20.0", squareMetres: "70.0"}]

    for fields <- propertyFields do
      Property.changeset(%Property{}, fields)
        |> Repo.insert
    end
  end

  test "query to retrieve the average rent in ranges is routed correctly" do
    response = build_conn()
      |> get("/query/averageRentInRanges")
      |> json_response(200)

    averageFrom60To65 = findByRange(response["result"], 60, 65)
    averageFrom85To90 = findByRange(response["result"], 85, 90)

    expectedAverageFrom60To65 = (10.0 + 15.0) / 2
    assertFloat(averageFrom60To65["averageRent"], expectedAverageFrom60To65)
    assertFloat(averageFrom85To90["averageRent"], 30.0)
  end

  test "query to retrieve the average rent is routed correctly" do
    response = build_conn()
      |> get("/query/averageRent?minSquareMetresExclusive=61&maxSquareMetresInclusive=90")
      |> json_response(200)

    averageRent = response["result"]["averageRent"]

    expectedAverageRent = (15.0 + 30.0 + 20.0) / 3
    assertFloat(averageRent, expectedAverageRent)
  end

  test "query to retrieve the cheapest property in ranges is routed correctly" do
    response = build_conn()
      |> get("/query/cheapestInRanges")
      |> json_response(200)

    cheapestFrom60To65 = findByRange(response["result"], 60, 65)
    cheapestFrom85To90 = findByRange(response["result"], 85, 90)

    cheapestDescriptionsFrom60To65 = for cheapest <- cheapestFrom60To65["cheapest"] do
      cheapest["description"]
    end

    assert cheapestDescriptionsFrom60To65 == ["a", "b"]

    singleCheapestFrom85To90 = Enum.at(cheapestFrom85To90["cheapest"], 0)
    assertProperty(singleCheapestFrom85To90, "c", 30.0, 85.5)
  end

  test "query to retrieve the cheapest properties is routed correctly" do
    response = build_conn()
      |> get("/query/cheapest?maxCount=1&minSquareMetresExclusive=61&maxSquareMetresInclusive=90")
      |> json_response(200)

    cheapest = Enum.at(response["result"], 0)

    assertProperty(cheapest, "b", 15.0, 61.5)
  end

  test "query to retrieve the priciest properties is routed correctly" do
    response = build_conn()
      |> get("/query/priciest?maxCount=1&minSquareMetresExclusive=61&maxSquareMetresInclusive=90")
      |> json_response(200)

    priciest = Enum.at(response["result"], 0)

    assertProperty(priciest, "c", 30.0, 85.5)
  end

  test "query to retrieve the properties with best rent per squareMetre is routed correctly" do
    response = build_conn()
      |> get("/query/rentPerSquareMetre?maxCount=2")
      |> json_response(200)

    %{"property" => property1, "rentPerSquareMetre" => rentPerSquareMetre1} = Enum.at(response["result"], 0)
    %{"property" => property2, "rentPerSquareMetre" => rentPerSquareMetre2} = Enum.at(response["result"], 1)

    expectedRentPerSquareMetre1 = 10.0 / 60.2
    expectedRentPerSquareMetre2 = 15.0 / 61.5

    assertFloat(rentPerSquareMetre1, expectedRentPerSquareMetre1)
    assertFloat(rentPerSquareMetre2, expectedRentPerSquareMetre2)
    assertProperty(property1, "a", 10.0, 60.2)
    assertProperty(property2, "b", 15.0, 61.5)
  end

  defp findByRange(result, min, max) do
    Enum.find(result, fn resultPart -> resultPart["range"]["min"] == min and
      resultPart["range"]["max"] == max end)
  end

  defp assertProperty(property, description, rent, squareMetres) do
    assert property["description"] == description
    assert property["rent"] == rent
    assert property["squareMetres"] == squareMetres
  end

  defp assertFloat(actual, expected) do
    assert expected - @epsilon <= actual
    assert actual <= expected + @epsilon
  end
end
