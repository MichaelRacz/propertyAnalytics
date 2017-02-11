defmodule Statistics.Query.Behaviour.Partition do
  #TODO doc for parameters
  @callback create(integer, integer, integer) :: [{integer, integer}]
end
