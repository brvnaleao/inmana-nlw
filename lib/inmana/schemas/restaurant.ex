defmodule Inmana.Schema.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset
  alias Inmana.Schema.Supply

  @required_fields [:name, :email]
  @email_regex ~r/^[A-Za-z0-9\._%+\-+']+@[A-Za-z0-9\.\-]+\.[A-Za-z]{2,4}$/

  @derive {Jason.Encoder, only: @required_fields ++ [:id]}
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "restaurants" do
    field :email, :string
    field :name, :string

    has_many :supplies, Supply

    timestamps()
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, @email_regex)
    |> validate_length(:name, min: 2)
    |> unique_constraint([:email])
  end
end
