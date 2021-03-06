defmodule BoardWeb.BacklogItemController do
  use BoardWeb, :controller

  alias Board.{Products.Product, ProductBacklogs, ProductBacklogs.BacklogItem}

  def index(conn, %{"product_id" => product_id}) do
    # TODO: restrict index to only products belonging to the user
    backlog_items = ProductBacklogs.list_backlog_items(product_id)

    json(conn, %{backlog_items: backlog_items})
  end

  # TODO: strong params-ish
  def create(conn, params) do
    ProductBacklogs.create_backlog_item(params)
    |> case do
      {:ok, backlog_item} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Backlog Item #{backlog_item.title} created successfully"})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{changeset: changeset})
    end
  end

  def delete(conn, %{"product_id" => product_id, "id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    # backlog_item = %BacklogItem{id: String.to_integer(id)}
    with %BacklogItem{} = backlog_item <- ProductBacklogs.get_backlog_item(id),
      :ok <- Bodyguard.permit(ProductBacklogs, :delete_backlog_item, user, %Product{id: product_id}),
        {:ok, _ } <- ProductBacklogs.delete_backlog_item(backlog_item) do
          conn
          |> put_status(:ok)
          |> json(nil)
    else
      _ ->
        conn
        |> put_status(:not_found)
        |> json(nil)
    end
  end
end
