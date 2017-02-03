defmodule Statistics.Query.Behaviour.Partition do
  @callback create(integer, integer, integer) :: [{integer, integer}]
end
