defmodule Insights.Repo.Migrations.DiscussionType do
  use Ecto.Migration

  def change do
    alter table(:meetings) do
      add :type, :string
    end
  end
end
