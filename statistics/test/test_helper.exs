ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(Statistics.Repo, :manual)

# dirty, but OK for this pet project
Code.require_file("test/query/test_partition.exs")
Code.require_file("test/query/pid_helper.exs")
