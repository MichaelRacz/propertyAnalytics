defmodule Statistics.Query.Behaviour.Partition do
  #TODO create doc for behaviours
  @callback create(integer, integer, integer) :: [{integer, integer}]
end
