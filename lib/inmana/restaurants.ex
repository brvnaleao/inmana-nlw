defmodule Inmana.Restaurants do
  @moduledoc """
  Restaunt's business logic
  """
  alias Inmana.Repo
  alias Inmana.Restaurants.Schema.Restaurant

  def create(params) do
    with %Ecto.Changeset{} = changeset <- Restaurant.changeset(params),
         {:ok, %Restaurant{}} = result <- Repo.insert(changeset) do
      result
    else
      {:error, result} -> {:error, %{result: result, status: :bad_request}}
    end
  end
end
