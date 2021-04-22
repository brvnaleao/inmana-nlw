defmodule InmanaWeb.RestaurantsController do
  use InmanaWeb, :controller

  alias InmanaWeb.FallbackController

  alias Inmana.Restaurants
  alias Inmana.Schema.Restaurant

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Restaurant{} = struct} <- Restaurants.create(params) do
      conn
      |> put_status(:created)
      |> render("create.json", restaurant: struct)
    end
  end
end
