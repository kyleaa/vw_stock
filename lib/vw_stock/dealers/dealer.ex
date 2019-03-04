defmodule VwStock.Dealers.Dealer do
  use Ecto.Schema
  import Ecto.Changeset
  alias VwStock.Dealers.Dealer


  schema "dealers" do
    field :update_batch_ts, :integer, default: 0
    field :raw_json, :map
    field :distance, :integer
    timestamps()
  end

  @doc false
  def changeset(%Dealer{} = dealer, attrs) do
    dealer
    |> cast(attrs, [:update_batch_ts, :raw_json, :distance])
    |> validate_required([:update_batch_ts, :raw_json, :distance])
  end

  def distance_to(%Dealer{raw_json: %{"latlong" => coord}}, target) do
    coord
    |> VwStock.Conversion.coord_string_to_tuple
    |> Distance.GreatCircle.distance(target)
    |> VwStock.Conversion.meters_to_miles
  end
end
