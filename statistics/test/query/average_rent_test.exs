defmodule Statistic.Query.AverageRentTest do
  use Statistics.ModelCase

  alias Statistics.Query
  alias Statistics.Property

  @valid_attributes %{description: "description", rent: 500.0, squareMetres: 50.0}
  @epsilon 0.1

  test "the average rent is returned" do
    for i <- 1..3 do
      Property.changeset(%Property{}, %{@valid_attributes | rent: i * 100.0})
        |> Repo.insert
    end

    averageRent = Query.AverageRent.execute

    expectedAverageRent = 200.0
    assert abs(averageRent - expectedAverageRent) <= @epsilon
  end

  test "returns nil when no property is committed" do
    averageRent = Query.AverageRent.execute

    assert averageRent == nil
  end

  test "only properties with min square metres < square metres are used for calculation" do
    for i <- 1..3 do
      attributes = %{@valid_attributes | rent: i * 100, squareMetres: i * 10}

      Property.changeset(%Property{}, attributes)
        |> Repo.insert
    end

    averageRent = Query.AverageRent.execute(20.0)

    expectedAverageRent = 300.0
    assert abs(averageRent - expectedAverageRent) <= @epsilon
  end

  test "only properties with square metres <= max square metres are returned" do
    for i <- 1..3 do
      attributes = %{@valid_attributes | rent: i * 100, squareMetres: i * 10}

      Property.changeset(%Property{}, attributes)
        |> Repo.insert
    end

    averageRent = Query.AverageRent.execute(0.0, 20.0)

    expectedAverageRent = 150.0
    assert abs(averageRent - expectedAverageRent) <= @epsilon
  end
end
