ExUnit.configure(exclude: :pending)
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Board.Repo, :manual)
