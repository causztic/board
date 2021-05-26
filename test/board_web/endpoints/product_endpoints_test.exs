import Board.Factories

defmodule BoardWeb.ProductEndpointsTest do
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


    test "POST /create returns correct status code and creates product", %{conn: conn} do
      product = build(:product)
      conn = post(conn, "/api/v1/products", Map.from_struct(product))

      %{products: products} = conn
        |> Guardian.Plug.current_resource
        |> Board.Repo.preload(:products)

      assert length(products) == 1

      created_product = List.first(products)

      assert created_product.title == product.title
      assert conn.status == 201
    end
  end
end
