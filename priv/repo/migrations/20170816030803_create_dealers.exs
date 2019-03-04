defmodule VwStock.Repo.Migrations.CreateDealers do
  use Ecto.Migration

  def change do
    create table(:dealers) do
      add :name, :string
      add :latlong, :string
      add :url, :string
      add :address1, :string
      add :address2, :string
      add :city, :string
      add :state, :string
      add :postalcode, :string
      add :raw_json, :map

      timestamps()
    end

  end
end
