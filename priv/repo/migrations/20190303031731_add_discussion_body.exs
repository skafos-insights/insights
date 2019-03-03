defmodule Insights.Repo.Migrations.AddDiscussionBody do
  use Ecto.Migration

  def change do
    alter table(:discussions) do
      add :body, :string
    end
  end
end
