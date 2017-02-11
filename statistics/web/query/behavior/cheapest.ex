defmodule Statistics.Query.Behaviour.Cheapest do
  alias Statistics.Property

  @callback execute(integer, integer, integer) :: [Property]
end
