defmodule Statistics.Query.RentPerSquareMetreTest do
  use Statistics.ModelCase

  alias Statistics.Query
  alias Statistics.Property

  import Kernel

  @valid_attributes %{description: "dummy", squareMetres: 76.2, rent: 608}
  @epsilon 0.1

  test "properties with lowest price per square metre are returned" do
    Property.changeset(%Property{}, %{@valid_attributes | squareMetres: 60.0, rent: 600.0})
    |> Repo.insert

    {:ok, expectedProperty} = Property.changeset(%Property{}, %{@valid_attributes | squareMetres: 70.0, rent: 600.0})
    |> Repo.insert

    [rentPerSquareMetreResult] = Query.RentPerSquareMetre.execute

    assertRentPerSquareMetreResult(rentPerSquareMetreResult, expectedProperty)
  end

  test "returns empty list when no property is committed" do
    result = Query.RentPerSquareMetre.execute

    assert result == []
  end

  test "n properties with lowest rent per square metre are returned" do
    properties = for rentFactor <- 4..1 do
      {:ok, property} = Property.changeset(%Property{}, %{@valid_attributes | squareMetres: 50.0, rent: 100.0 * rentFactor})
      |> Repo.insert

      property
    end

    expectedProperties = Enum.reverse(properties)
    |> Enum.take(2)

    rentPerSquareMetreResults = Query.RentPerSquareMetre.execute(2)

    assert length(rentPerSquareMetreResults) == 2

    for i <- 0..1 do
      assertRentPerSquareMetreResult(Enum.at(rentPerSquareMetreResults, i),
        Enum.at(expectedProperties, i))
    end
  end

  defp assertRentPerSquareMetreResult(rentPerSquareMetreResult, expectedProperty) do
    {property, rentPerSquareMetre} = rentPerSquareMetreResult
    assert property == expectedProperty

    expectedRentPerSquareMetre = expectedProperty.rent / expectedProperty.squareMetres
    assert abs(rentPerSquareMetre - expectedRentPerSquareMetre) <= @epsilon
  end

  # TODO improve test to cover square metre borders (also in other tests)
end
