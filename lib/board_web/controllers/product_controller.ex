defmodule BoardWeb.ProductController do
  use BoardWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
