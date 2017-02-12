defmodule Statistics.Router do
  use Statistics.Web, :router

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

  scope "/", Statistics do
    pipe_through :browser

    get "/", PageController, :index
    resources "/properties", PropertyController
  end

  scope "/query", Statistics do
    pipe_through :api

    get "/averageRentInRanges", QueryController, :averageRentInRanges
    get "/averageRent", QueryController, :averageRent
    get "/cheapestInRanges", QueryController, :cheapestInRanges
    get "/cheapest", QueryController, :cheapest
    get "/priciest", QueryController, :priciest
    get "/rentPerSquareMetre", QueryController, :rentPerSquareMetre
  end
end
