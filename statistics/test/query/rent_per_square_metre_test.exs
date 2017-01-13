defmodule Statistics.Query.RentPerSquareMetreTest do
  use Statistics.ModelCase

  alias Statistics.Query
  alias Statistics.Property

  import Kernel

  @valid_attributes %{description: "dummy", squareMetres: 76.2, rent: 608}

  test "properties with lowest price per square metre are returned" do
    Property.changeset(%Property{}, %{@valid_attributes | squareMetres: 60.0, rent: 600.0})
    |> Repo.insert

    {:ok, expectedProperty} = Property.changeset(%Property{}, %{@valid_attributes | squareMetres: 70.0, rent: 600.0})
    |> Repo.insert

    expectedRentPerSquareMetre = 600.0 / 70.0

    [{property, rentPerSquareMetre}] = Query.RentPerSquareMetre.execute

    assert property == expectedProperty
    assert abs(rentPerSquareMetre - expectedRentPerSquareMetre) <= 0.1
  end
end
