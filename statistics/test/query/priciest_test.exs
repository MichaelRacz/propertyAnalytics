defmodule Statistics.Query.PriciestTest do
  use Statistics.ModelCase

  alias Statistics.Query
  alias Statistics.Property

  @valid_attributes %{description: "dummy", squareMetres: 76.2, rent: 608}

  test "the priciest property is returned" do
    Property.changeset(%Property{}, %{@valid_attributes | rent: 100})
      |> Repo.insert

    {:ok, expectedPriciest} = Property.changeset(%Property{}, %{@valid_attributes | rent: 200})
      |> Repo.insert

    priciest = Query.Priciest.execute

    assert priciest == [expectedPriciest]
  end

  test "returns empty list when no property is committed" do
    priciest = Query.Priciest.execute

    assert priciest == []
  end

  test "n priciest properties are returned" do
      properties = for rent <- 1..4 do
        {:ok, property} = Property.changeset(%Property{}, %{@valid_attributes | rent: rent})
          |> Repo.insert

        property
      end

      priciest = Query.Priciest.execute(3)

      expectedPriciest = Enum.reverse(properties)
        |> Enum.take(3)

      assert priciest == expectedPriciest
  end

  test "only properties with min square metres < square metres are returned" do
    properties = for squareMetres <- 1..3 do
      {:ok, property} = Property.changeset(%Property{}, %{@valid_attributes | squareMetres: squareMetres * 10.0})
        |> Repo.insert

      property
    end

    priciestInRange = Query.Priciest.execute(2, 20.0)

    expectedPriciestInRange = Enum.at(properties, 2)
    assert priciestInRange == [expectedPriciestInRange]
  end

  test "only properties with square metres <= max square metres are returned" do
    properties = for squareMetres <- 1..3 do
      {:ok, property} = Property.changeset(%Property{}, %{@valid_attributes | squareMetres: squareMetres * 10.0})
        |> Repo.insert

      property
    end

    priciestInRange = Query.Priciest.execute(2, 10.0, 20.0)

    expectedPriciestInRange = Enum.at(properties, 1)
    assert priciestInRange == [expectedPriciestInRange]
  end
end
