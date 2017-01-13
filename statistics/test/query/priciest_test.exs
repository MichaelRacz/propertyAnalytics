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

  test "only properties with min rent < rent are returned" do
    properties = for rent <- 1..3 do
      {:ok, property} = Property.changeset(%Property{}, %{@valid_attributes | rent: rent})
        |> Repo.insert

      property
    end

    priciest = Query.Priciest.execute(2, 2.0)

    expectedPriciest = Enum.at(properties, 2)
    assert priciest == [expectedPriciest]
  end

  test "only properties with rent <= max rent are returned" do
    properties = for rent <- 1..3 do
      {:ok, property} = Property.changeset(%Property{}, %{@valid_attributes | rent: rent})
        |> Repo.insert

      property
    end

    priciest = Query.Priciest.execute(2, 1.0, 2.0)

    expectedPriciest = Enum.at(properties, 1)
    assert priciest == [expectedPriciest]
  end
end
