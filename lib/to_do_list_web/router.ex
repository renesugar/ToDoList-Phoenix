defmodule ToDoListWeb.Router do
  use ToDoListWeb, :router

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

  scope "/", ToDoListWeb do
    pipe_through :browser # Use the default browser stack

    get "/", ToDoController, :index
    resources "/todo", ToDoController
    patch "/todo/:id/check", ToDoController, :check
  end

  # Other scopes may use custom stacks.
  # scope "/api", ToDoListWeb do
  #   pipe_through :api
  # end
end
