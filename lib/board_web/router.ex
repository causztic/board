defmodule BoardWeb.Router do
  use BoardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Our pipeline implements "maybe" authenticated. We'll use the `:ensure_auth` below for when we need to make sure someone is logged in.
  pipeline :auth do
    plug Board.Accounts.Pipeline
  end

  # We use ensure_auth to fail if there is no one logged in
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
    plug :set_current_user
  end

  scope "/", BoardWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index
  end

  scope "/api/v1/", BoardWeb do
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
  end

  # Definitely logged in scope
  scope "/api/v1", BoardWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    resources "/products", ProductController do
      resources "/backlog_items", BacklogItemController
    end
  end

  defp set_current_user(conn, _) do
    token = Guardian.Plug.current_token(conn)
    user = Guardian.Plug.current_resource(conn)

    conn
    |> assign(:user_token, token)
    |> assign(:current_user, user)
  end
end
