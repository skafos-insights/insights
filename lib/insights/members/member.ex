defmodule Insights.Members.Member do
  use Ecto.Schema
  import Ecto.Changeset


  schema "members" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
