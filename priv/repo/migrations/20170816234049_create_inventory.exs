defmodule VwStock.Repo.Migrations.CreateInventory do
  use Ecto.Migration

  def change do
    create table(:inventory, primary_key: false) do
      add :vin, :string
      add :dealer_id, :integer
      add :update_batch_ts, :integer
      add :raw_json, :map

      timestamps()
    end

    create index(:inventory, [:vin, :dealer_id], unique: true)

    alter table(:dealers) do
      remove :name
      remove :latlong
      remove :url
      remove :address1
      remove :address2
      remove :city
      remove :state
      remove :postalcode
      add :update_batch_ts, :integer
    end
  end
end
