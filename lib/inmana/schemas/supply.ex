defmodule Inmana.Schema.Supply do
  use Ecto.Schema
  import Ecto.Changeset

  alias Inmana.Schema.Restaurant

  @required_fields [:description, :expiration_date, :responsible, :restaurant_id]

  @derive {Jason.Encoder, only: @required_fields ++ [:id]}
  @foreign_key_type :binary_id

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "supplies" do
    field :responsible, :string
    field :description, :string
    field :expiration_date, :date

    belongs_to :restaurant, Restaurant

    timestamps()
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:description, min: 3)
    |> validate_length(:responsible, min: 2)
  end
end
