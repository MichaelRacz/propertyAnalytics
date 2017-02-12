defmodule Statistics.PropertyControllerTest do
  use Statistics.ConnCase

  alias Statistics.Property

  @valid_attrs %{description: "description of the property", rent: "750.5", squareMetres: "60.2"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, property_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing properties"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, property_path(conn, :new)
    assert html_response(conn, 200) =~ "New property"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, property_path(conn, :create), property: @valid_attrs
    assert redirected_to(conn) == property_path(conn, :index)
    assert Repo.get_by(Property, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, property_path(conn, :create), property: @invalid_attrs
    assert html_response(conn, 200) =~ "New property"
  end

  test "shows chosen resource", %{conn: conn} do
    property = Repo.insert! %Property{}
    conn = get conn, property_path(conn, :show, property)
    assert html_response(conn, 200) =~ "Show property"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, property_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    property = Repo.insert! %Property{}
    conn = get conn, property_path(conn, :edit, property)
    assert html_response(conn, 200) =~ "Edit property"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    property = Repo.insert! %Property{}
    conn = put conn, property_path(conn, :update, property), property: @valid_attrs
    assert redirected_to(conn) == property_path(conn, :show, property)
    assert Repo.get_by(Property, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    property = Repo.insert! %Property{}
    conn = put conn, property_path(conn, :update, property), property: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit property"
  end

  test "deletes chosen resource", %{conn: conn} do
    property = Repo.insert! %Property{}
    conn = delete conn, property_path(conn, :delete, property)
    assert redirected_to(conn) == property_path(conn, :index)
    refute Repo.get(Property, property.id)
  end
end
