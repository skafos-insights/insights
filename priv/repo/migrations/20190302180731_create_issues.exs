defmodule Insights.Repo.Migrations.CreateIssues do
  use Ecto.Migration

  def change do
    create table(:issues) do
      add :description, :string
      add :identifier, :string
      add :importance, :float
      add :appropriations, :integer
      add :status, :string
      add :urls, :string

      timestamps()
    end

  end
end
