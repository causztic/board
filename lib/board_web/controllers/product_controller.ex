defmodule BoardWeb.ProductController do
  use BoardWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
