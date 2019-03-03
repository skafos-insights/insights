defmodule Insights.Repo.Migrations.PermissiveDataModel do
  use Ecto.Migration

  def change do
    alter table(:discussions) do
      add :votes, :string
    end

    alter table(:meetings) do
      add :title, :string
    end
  end
end
