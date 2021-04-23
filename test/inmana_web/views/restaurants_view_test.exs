defmodule Inmana.RestaurantsViewTest do
  use InmanaWeb.ConnCase, async: true

  import Phoenix.View

  alias InmanaWeb.RestaurantsView
  alias Inmana.Restaurants.Schema.Restaurant

  describe "render/1" do
    test "renders create.json" do
      params = %{name: "Suri cascudo", email: "siri@cascudo.com"}

      changeset = Restaurant.changeset(params)
      restaurant = Inmana.Repo.insert(changeset)

      response = render(RestaurantsView, "create.json", restaurant: restaurant)

      assert %{
               message: "Restaurant created",
               restaurant:
                 {:ok,
                  %Restaurant{
                    email: "siri@cascudo.com",
                    id: _id,
                    name: "Suri cascudo"
                  }}
             } = response
    end
  end
end
