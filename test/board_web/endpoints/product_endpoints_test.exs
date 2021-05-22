import Board.Factories

defmodule BoardWeb.ProductEndpointsTest do
  use BoardWeb.ConnCase
  # TODO: shared examples for authentication

  describe "unauthenticated" do
    test "returns 401 if not logged in", %{conn: conn} do
      conn = get(conn, "/products/new")
      assert conn.status == 401
    end
  end

  describe "authenticated" do

    setup %{conn: conn} do
      user = insert!(:user)
      {:ok, jwt, _claims} = Board.Accounts.Guardian.encode_and_sign(user)
      conn =
        conn
        |> put_req_header("authorization", "Bearer #{jwt}")

      {:ok, conn: conn}
    end

    test "GET /new returns 200", %{conn: conn} do
      conn = get(conn, "/products/new")
      assert conn.status == 200
    end

    test "POST /create redirects to root page", %{conn: conn} do
      product = build(:product)
      conn = post(conn, "/products", %{ "product" => Map.from_struct(product) })

      %{products: products} = conn.assigns.current_user
        |> Board.Repo.preload(:products)

      assert length(products) == 1

      created_product = List.first(products)

      assert created_product.title == product.title
      assert conn.status == 302
    end
  end
end
