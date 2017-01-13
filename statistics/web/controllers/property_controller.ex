defmodule Statistics.PropertyController do
  use Statistics.Web, :controller

  alias Statistics.Property

  def index(conn, _params) do
    properties = Repo.all(Property)
    render(conn, "index.html", properties: properties)
  end

  def new(conn, _params) do
    changeset = Property.changeset(%Property{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"property" => property_params}) do
    changeset = Property.changeset(%Property{}, property_params)

    case Repo.insert(changeset) do
      {:ok, _property} ->
        conn
        |> put_flash(:info, "Property created successfully.")
        |> redirect(to: property_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    property = Repo.get!(Property, id)
    render(conn, "show.html", property: property)
  end

  def edit(conn, %{"id" => id}) do
    property = Repo.get!(Property, id)
    changeset = Property.changeset(property)
    render(conn, "edit.html", property: property, changeset: changeset)
  end

  def update(conn, %{"id" => id, "property" => property_params}) do
    property = Repo.get!(Property, id)
    changeset = Property.changeset(property, property_params)

    case Repo.update(changeset) do
      {:ok, property} ->
        conn
        |> put_flash(:info, "Property updated successfully.")
        |> redirect(to: property_path(conn, :show, property))
      {:error, changeset} ->
        render(conn, "edit.html", property: property, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    property = Repo.get!(Property, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(property)

    conn
    |> put_flash(:info, "Property deleted successfully.")
    |> redirect(to: property_path(conn, :index))
  end
end
