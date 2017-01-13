defmodule Statistics.Query.RentPerSquareMetre do
  import Ecto.Query

  alias Statistics.Property

#order_by: [asc: property.rent / property.squareMetres]
  def execute do
    from property in Property,
      limit: 1,
      select: {property, property.rent + property.squareMetres} #, property.rent / property.squareMetres}
      |> order_by([property], property.rent + property.squareMetres)
  end
end
