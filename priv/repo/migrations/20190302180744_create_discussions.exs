defmodule Insights.Repo.Migrations.CreateDiscussions do
  use Ecto.Migration

  def change do
    create table(:discussions) do
      add :present, :string
      add :absent, :string
      add :meeting, references(:meetings, on_delete: :nothing)
      add :issue, references(:issues, on_delete: :nothing)

      timestamps()
    end

    create index(:discussions, [:meeting])
    create index(:discussions, [:issue])
  end
end
