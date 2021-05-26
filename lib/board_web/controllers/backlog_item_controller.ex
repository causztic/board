defmodule BoardWeb.BacklogItemController do
  use BoardWeb, :controller

  alias Board.{Products}

  def index(conn, %{ "product_id" => product_id }) do
    # TODO: restrict index to only products belonging to the user
    backlog_items = Products.list_backlog_items(product_id)

    json(conn, %{ backlog_items: backlog_items })
  end
end
