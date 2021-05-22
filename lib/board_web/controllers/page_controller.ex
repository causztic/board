defmodule BoardWeb.PageController do
  use BoardWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def protected(conn, _) do
    render(conn, "protected.html")
  end
end
