defmodule BoardWeb.BoardChannel do
  use Phoenix.Channel

  # TODO: validate product id
  def join("board:products:" <> _product_id, _message, socket) do
    {:ok, socket}
  end

  def handle_in("ping", %{"body" => body}, socket) do
    broadcast!(socket, "ping!", %{body: body})
    {:noreply, socket}
  end
end
