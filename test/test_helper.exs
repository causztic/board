{:ok, _} = Application.ensure_all_started(:ex_machina)

ExUnit.configure(exclude: :not_implemented)
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Board.Repo, :manual)
