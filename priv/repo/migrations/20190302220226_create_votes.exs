defmodule Insights.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :vote_type, :integer
      add :member_id, references(:members, on_delete: :nothing)
      add :discussion, references(:discussions, on_delete: :nothing)

      timestamps()
    end

    create index(:votes, [:member_id])
    create index(:votes, [:discussion])
  end
end
