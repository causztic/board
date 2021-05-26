defmodule BoardWeb.SessionController do
  use BoardWeb, :controller

  alias Board.{Accounts, Accounts.Guardian}

  def login(conn, %{"email" => email, "password" => password}) do
    Accounts.authenticate_user(email, password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.current_token
    |> Guardian.revoke

    send_resp(conn, :ok, "")
  end

  defp login_reply({:ok, user}, conn) do
    {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)

    conn
    |> json(%{token: jwt})
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_status(:unauthorized)
    |> json(%{reason: to_string(reason)})
  end
end
