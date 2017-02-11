defmodule Statistics.Query.Behaviour.AverageRent do
  alias Statistics.Property

  @callback execute(integer, integer) :: [Property]
end
