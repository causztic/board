defmodule BoardWeb.BacklogItemController do
  use BoardWeb, :controller

  alias Board.{Products}

  def index(conn, %{ "product_id" => product_id }) do
    backlog_items = Products.list_backlog_items(product_id)

    render(conn, "index.html", backlog_items: backlog_items)
  end
end
