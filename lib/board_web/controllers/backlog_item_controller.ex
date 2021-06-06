defmodule BoardWeb.BacklogItemController do
  use BoardWeb, :controller

  alias Board.{Products}

  def index(conn, %{ "product_id" => product_id }) do
    # TODO: restrict index to only products belonging to the user
    backlog_items = Products.list_backlog_items(product_id)

    json(conn, %{ backlog_items: backlog_items })
  end

  # TODO: strong params-ish
  def create(conn, params) do
    Products.create_backlog_item(params)
    |> case do
      {:ok, backlog_item} ->
        conn
        |> put_status(:created)
        |> json(%{ message: "Backlog Item #{backlog_item.title} created successfully" })

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{ changeset: changeset })
    end
  end
end
