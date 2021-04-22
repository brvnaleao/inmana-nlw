defmodule InmanaWeb.SuppliesController do
  use InmanaWeb, :controller

  alias InmanaWeb.FallbackController

  alias Inmana.Schema.Supply

  alias Inmana.Supplies

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Supply{} = struct} <- Supplies.create(params) do
      conn
      |> put_status(:created)
      |> render("create.json", supply: struct)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Supply{} = struct} <- Supplies.fetch_supply(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", supply: struct)
    end
  end
end
