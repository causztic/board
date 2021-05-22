defmodule BoardWeb.ProductEndpointsTest do
  use BoardWeb.ConnCase
  # TODO: shared examples for authentication

  test "shows unauthenticated if not logged in", %{conn: conn} do
    conn = get(conn, "/products/new")
    assert conn.status == 401
  end
end
