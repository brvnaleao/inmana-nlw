defmodule Inmana.RestaurantsController do
  use InmanaWeb.ConnCase, async: true

  describe "create/2" do
    test "when all params are valid, returns a restaurant", %{conn: conn} do
      params = %{name: "Suri cascudo", email: "siri@cascudo.com"}

      response =
        conn
        |> post(Routes.restaurants_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "Restaurant created",
               "restaurant" => %{
                 "email" => "siri@cascudo.com",
                 "name" => "Suri cascudo",
                 "id" => _id
               }
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{name: "", email: "siri@cascudo.com"}

      response =
        conn
        |> post(Routes.restaurants_path(conn, :create, params))
        |> json_response(:bad_request)

      assert response == %{"message" => %{"name" => ["can't be blank"]}}
    end
  end
end
