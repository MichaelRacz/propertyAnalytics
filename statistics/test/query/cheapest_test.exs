defmodule Statistics.Query.CheapestTest do
  use Statistics.ModelCase

  alias Statistics.Query
  alias Statistics.Property

  @valid_attributes %{description: "dummy", squareMetres: 76.2, rent: 608}

  test "the cheapest property is returned" do
    Property.changeset(%Property{}, %{@valid_attributes | rent: 200})
    |> Repo.insert

    {:ok, expectedCheapest} = Property.changeset(%Property{}, %{@valid_attributes | rent: 100})
    |> Repo.insert

    cheapest = Query.Cheapest.execute

    assert cheapest == [expectedCheapest]
  end

  test "returns empty list when no property is committed" do
    cheapest = Query.Cheapest.execute

    assert cheapest == []
  end

  test "n cheapest properties are returned" do
      properties = for rent <- 4..1 do
        {:ok, property} = Property.changeset(%Property{}, %{@valid_attributes | rent: rent})
        |> Repo.insert

        property
      end

      cheapest = Query.Cheapest.execute(3)

      expectedCheapest = Enum.reverse(properties)
      |> Enum.take(3)

      assert cheapest == expectedCheapest
  end

  test "only properties with min square metres < square metres are returned" do
    properties = for squareMetres <- 1..3 do
      {:ok, property} = Property.changeset(%Property{}, %{@valid_attributes | squareMetres: squareMetres * 10})
        |> Repo.insert

      property
    end

    cheapestInRange = Query.Cheapest.execute(2, 20)

    expectedCheapestInRange = Enum.at(properties, 2)
    assert cheapestInRange == [expectedCheapestInRange]
  end

  test "only properties with square metres <= max square metres are returned" do
    properties = for squareMetres <- 1..3 do
      {:ok, property} = Property.changeset(%Property{}, %{@valid_attributes | squareMetres: squareMetres * 10})
      |> Repo.insert

      property
    end

    cheapestInRange = Query.Cheapest.execute(2, 10, 20)

    expectedCheapestInRange = Enum.at(properties, 1)
    assert cheapestInRange == [expectedCheapestInRange]
  end
end
