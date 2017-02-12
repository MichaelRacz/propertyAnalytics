defmodule Statistics.Query.PidHelper do
  def setTestPid(pid) do
    Agent.start_link(fn -> pid end, name: :testPidAgent)
  end

  def getTestPid() do
    Agent.get(:testPidAgent, fn pid -> pid end)
  end
end
