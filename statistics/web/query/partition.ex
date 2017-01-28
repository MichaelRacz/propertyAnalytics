defmodule Statistics.Query.Partition do
  def create(min, max, step) when min < max and step > 0 do
    intervalMax = min + step
    if  intervalMax >= max do
      [{min, max}]
    else
      [{min, intervalMax} | create(intervalMax, max, step)]
    end
  end
end
