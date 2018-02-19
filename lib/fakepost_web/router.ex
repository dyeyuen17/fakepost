defmodule FakepostWeb.Router do
  use FakepostWeb, :router

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

  pipeline :auth do
    plug Fakepost.Accounts.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", FakepostWeb do
    pipe_through [:browser, :auth]# Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :delete]
    post "/sessions", SessionController, :authenticate_user
  end

  scope "/", FakepostWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    get "/home", SessionController, :home
  end

  pipeline :with_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Fakepost.Accounts.CurrentUser
  end

  # Other scopes may use custom stacks.
  # scope "/api", FakepostWeb do
  #   pipe_through :api
  # end
end
