defmodule VwStock.Repo.Migrations.AddHomeDistance do
  use Ecto.Migration

  def change do
    alter table(:dealers) do
      add :distance, :integer
    end
  end
end
