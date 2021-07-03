defmodule BoardWeb.BacklogItemEndpointsTest do
  use BoardWeb.ConnCase
  alias Board.{Products, ProductBacklogs}
  # TODO: shared examples for authentication

  describe "authenticated" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, product} = Products.create_product(user, %{title: "test"})
      {:ok, jwt, _claims} = Board.Accounts.Guardian.encode_and_sign(user)
      conn =
        conn
        |> put_req_header("authorization", "Bearer #{jwt}")

      [conn: conn, product: product]
    end

    test "backlog_items#create"

    test "DELETE a backlog item with a missing product id", %{conn: conn} do
      conn = delete(conn, "/api/v1/products/1/backlog_items/1")

      assert conn.status == 404
    end

    test "DELETE a backlog item with a valid product but a missing backlog item", %{conn: conn, product: product} do
      conn = delete(conn, "/api/v1/products/#{product.id}/backlog_items/1")

      assert conn.status == 404
    end

    test "DELETE a backlog item with a valid backlog item", %{conn: conn, product: product} do
      backlog_item = insert(:backlog_item, %{product_id: product.id})
      conn = delete(conn, "/api/v1/products/#{product.id}/backlog_items/#{backlog_item.id}")

      assert length(ProductBacklogs.list_backlog_items) == 0
      assert conn.status == 200
    end
  end
end
