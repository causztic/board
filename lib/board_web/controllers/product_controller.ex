defmodule BoardWeb.ProductController do
  use BoardWeb, :controller

  alias Board.Products

  def index(conn, _params) do
    products =
      conn
      |> Guardian.Plug.current_resource()
      |> Products.list_products()

    json(conn, %{ products: products })
  end

  # TODO: strong params-ish
  def create(conn, params) do
    conn
    |> Guardian.Plug.current_resource()
    |> Products.create_product(params)
    |> case do
      {:ok, product} ->
        conn
        |> put_status(:created)
        |> json(%{ message: "Product #{product.title} created successfully" })

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{ changeset: changeset })
    end
  end
end
