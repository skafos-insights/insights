defmodule Insights.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
