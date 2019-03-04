defmodule VwStockWeb.Router do
  use VwStockWeb, :router

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

  scope "/", VwStockWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/dealers/map", DealerController, :map

    resources "/dealers", DealerController, except: [:edit, :new, :update] do
      resources "/inventory", InventoryController, only: [:show]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", VwStockWeb do
  #   pipe_through :api
  # end
end
