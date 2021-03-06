defmodule BoardWeb.UserSocket do
  use Phoenix.Socket
  alias Guardian

  ## Channels
  # channel "room:*", BoardWeb.RoomChannel
  channel "board:*", BoardWeb.BoardChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.

  def connect(%{"token" => token}, socket) do
    case Guardian.Phoenix.Socket.authenticate(socket, Board.Accounts.Guardian, token) do
      {:ok, socket} ->
        user = Guardian.Phoenix.Socket.current_resource(socket).id
        {:ok, assign(socket, :user_id, user)}
      {:error, _} -> :error
    end
  end

  # This function will be called when there was no authentication information
  def connect(_params, _socket) do
    :error
  end
  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     BoardWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(socket), do: "user_socket:#{socket.assigns.user_id}"
end
