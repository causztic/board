ExUnit.configure(exclude: :not_implemented)
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Board.Repo, :manual)
