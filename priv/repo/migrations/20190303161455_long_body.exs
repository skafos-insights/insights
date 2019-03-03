defmodule Insights.Repo.Migrations.LongBody do
  use Ecto.Migration

  def change do
    alter table(:discussions) do
      modify :body, :text
      modify :votes, :text
    end

    alter table(:meetings) do
      modify :title, :text
    end
  end
end
