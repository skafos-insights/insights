defmodule Insights.Repo.Migrations.EnhanceDiscussionModel do
  use Ecto.Migration

  def change do
    alter table(:discussions) do
      add :type, :string
      add :discussion_type, :string
      add :dollar_amount, :string
      add :status, :string
    end
  end
end
