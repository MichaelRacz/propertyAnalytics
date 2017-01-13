defmodule Statistics.PropertyTest do
  use Statistics.ModelCase

  alias Statistics.Property

  @valid_attrs %{description: "description of the property", rent: "0.1", squareMetres: "0.1"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Property.changeset(%Property{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Property.changeset(%Property{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "description must not be empty" do
    attributes = %{@valid_attrs | description: ""}
    changeset = Property.changeset(%Property{}, attributes)
    refute changeset.valid?
  end

  test "description must not consist of whitespaces only" do
    attributes = %{@valid_attrs | description: " \t\r\n"}
    changeset = Property.changeset(%Property{}, attributes)
    refute changeset.valid?
  end

  test "description is trimmed" do
    attributes = %{@valid_attrs | description: " description\t\r\n"}
    changeset = Property.changeset(%Property{}, attributes)
    assert changeset.changes.description == "description"
  end

  @positive_fields [:squareMetres, :rent]
  @not_positive_values [0.0, -1.0]

  test "squareMetres and rent must be positive" do
    for field <- @positive_fields, value <- @not_positive_values do
      attributes = %{@valid_attrs | field => value}
      assert {field, "must be greater than 0"} in errors_on(%Property{}, attributes)
    end
  end
end
