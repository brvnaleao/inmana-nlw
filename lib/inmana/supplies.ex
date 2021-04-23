defmodule Inmana.Supplies do
  @moduledoc """
  Supply's business logic
  """
  alias Inmana.Repo
  alias Inmana.Restaurants.Schema.Restaurant
  alias Inmana.Supplies.Schema.Supply
  import Ecto.Query

  def create(params) do
    with %Ecto.Changeset{} = changeset <- Supply.changeset(params),
         {:ok, %Supply{}} = result <- Repo.insert(changeset) do
      result
    else
      {:error, result} -> {:error, %{result: result, status: :bad_request}}
    end
  end

  def fetch_supply(uuid) do
    case Repo.get(Supply, uuid) do
      %Supply{} = supply -> {:ok, supply}
      nil -> {:error, %{result: "Supply not found", status: :not_found}}
    end
  end

  def get_by_expiration do
    today = Date.utc_today()
    beginning_of_week = Date.beginning_of_week(today)
    end_of_week = Date.end_of_week(today)

    query =
      from supply in Supply,
        where:
          supply.expiration_date >= ^beginning_of_week and
            supply.expiration_date <= ^end_of_week,
        preload: [:restaurant]

    query
    |> Repo.all()
    |> Enum.group_by(fn %Supply{restaurant: %Restaurant{email: email}} -> email end)
  end
end
