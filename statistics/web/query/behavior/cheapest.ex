defmodule Statistics.Query.Behaviour.Cheapest do
  alias Statistics.Property

  @callback execute(integer, float, float) :: [Property]
end
