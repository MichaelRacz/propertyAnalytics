defmodule Statistics.Property do
  use Statistics.Web, :model

  schema "properties" do
    field :description, :string
    field :squareMetres, :float
    field :rent, :float

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :squareMetres, :rent])
    |> trim(:description)
    |> validate_required([:description, :squareMetres, :rent])
    |> validate_number(:squareMetres, greater_than: 0)
    |> validate_number(:rent, greater_than: 0)
  end

  defp trim(changeset, field) do
    case changeset.changes[field] do
      nil -> changeset
      valueToTrim ->
        case String.trim(valueToTrim) do
          ^valueToTrim -> changeset
          trimmedValue -> Ecto.Changeset.change(changeset, %{field => trimmedValue})
        end
    end
  end
end
