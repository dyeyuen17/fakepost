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
    plug Fakepost.Accounts.CurrentUser
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
    plug Fakepost.Accounts.CurrentUser
  end

  scope "/", FakepostWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index
    resources "/users", UserController, only: [:show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :delete]
    post "/sessions", SessionController, :authenticate_user

    scope "/" do
      pipe_through [:login_required]

      resources "/users", UserController, only: [:show] do
        resources "/posts", PostController
        post "/new", PostController, :new
      end
    end

  end

  scope "/", FakepostWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    get "/home", SessionController, :home
  end



  # Other scopes may use custom stacks.
  # scope "/api", FakepostWeb do
  #   pipe_through :api
  # end




  pipeline :login_required do
    plug Guardian.Plug.EnsureAuthenticated,
       handler: Fakepost.Accounts.LoginGuard
  end


end
