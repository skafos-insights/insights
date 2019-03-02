defmodule Insights.Meetings.Meeting do
  use Ecto.Schema
  import Ecto.Changeset


  schema "meetings" do
    field :body, :string
    field :date, :date
    field :detail_url, :string
    field :summary_url, :string

    timestamps()
  end

  @doc false
  def changeset(meeting, attrs) do
    meeting
    |> cast(attrs, [:date, :summary_url, :detail_url, :body])
    |> validate_required([:date, :summary_url, :detail_url, :body])
  end
end
