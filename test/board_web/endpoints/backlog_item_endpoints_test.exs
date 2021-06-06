import Board.Factories

defmodule BoardWeb.BacklogItemEndpointsTest do
  use BoardWeb.ConnCase
  # TODO: shared examples for authentication

  describe "authenticated" do
    setup %{conn: conn} do
      user = insert!(:user)
      {:ok, jwt, _claims} = Board.Accounts.Guardian.encode_and_sign(user)
      conn =
        conn
        |> put_req_header("authorization", "Bearer #{jwt}")

      {:ok, conn: conn}
    end

    @tag :pending
    test 'backlog_items#create'

    @tag :pending
    test 'backlog_items#delete'
  end
end
