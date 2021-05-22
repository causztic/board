defmodule BoardWeb.ProductController do
  use BoardWeb, :controller

  alias Board.{Products, Products.Product}

  def index(conn, _params) do
    products = conn.assigns.current_user
      |> Products.list_products

    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    changeset = Product.changeset(%Product{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do
    conn.assigns.current_user
      |> Products.create_product(product_params)
      |> case do
        {:ok, product} ->
          conn
            |> put_flash(:info, "Product #{product.title} created successfully")
            |> redirect(to: Routes.page_path(conn, :index))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
  end
end
