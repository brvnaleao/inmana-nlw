defmodule Inmana.Restaurants.Schema.RestaurantTest do
  use Inmana.DataCase, async: true
  alias Inmana.Restaurants.Schema.Restaurant

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Suri cascudo", email: "siri@cascudo.com"}

      response = Restaurant.changeset(params)

      assert %Ecto.Changeset{
               changes: %{name: "Suri cascudo", email: "siri@cascudo.com"},
               valid?: true
             } = response
    end

    test "when there is a invalid email, returns a invalid changeset" do
      params = %{name: "Suri cascudo", email: "siri"}

      response = Restaurant.changeset(params)

      assert %Ecto.Changeset{valid?: false} = response
      assert errors_on(response) == %{email: ["has invalid format"]}
    end

    test "when there is an empty name, returns a invalid changeset" do
      params = %{name: "", email: "siricascudo@test.com"}

      response = Restaurant.changeset(params)

      assert %Ecto.Changeset{valid?: false} = response
      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end
end
