defmodule VwStock.Dealers.Inventory do
  use Ecto.Schema
  import Ecto.Changeset
  alias VwStock.Dealers.Inventory

  @primary_key false
  schema "inventory" do
    field :vin, :string, primary_key: true
    field :dealer_id, :integer, primary_key: true
    field :update_batch_ts, :integer
    field :raw_json, :map

    timestamps()
  end

  @doc false
  def changeset(%Inventory{} = inventory, attrs) do
    inventory
    |> cast(attrs, [:vin, :dealer_id, :update_batch_ts, :raw_json])
    |> validate_required([:vin, :dealer_id, :update_batch_ts, :raw_json])
  end
end
