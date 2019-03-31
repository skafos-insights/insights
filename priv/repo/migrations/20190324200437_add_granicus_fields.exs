defmodule Insights.Repo.Migrations.AddGranicusFields do
  use Ecto.Migration

  def change do
    alter table(:meetings) do
      add :granicus_clip_id, :integer
      add :media_player, :string
      add :agenda_html_url, :string
      add :duration, :integer
      add :granicus_duration, :string
      add :granicus_mp4, :string
      add :video_file, :string
    end
	
    alter table(:discussions) do
      add :documents, :json
      add :timestamp, :integer
      add :duration, :integer
      add :video_file, :string
    end
  end
end
