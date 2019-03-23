defmodule Insights.Repo.Migrations.Texttext do
  use Ecto.Migration

  def change do
    alter table(:discussions) do
      modify :body, :text
      modify :absent, :text
      modify :present, :text
      modify :discussion_type, :text
      modify :dollar_amount, :text
      modify :status, :text
      modify :votes, :text
      modify :type, :text
    end
  end
end
