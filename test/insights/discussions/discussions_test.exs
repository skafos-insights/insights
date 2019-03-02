defmodule Insights.DiscussionsTest do
  use Insights.DataCase

  alias Insights.Discussions

  describe "discussions" do
    alias Insights.Discussions.Discussion

    @valid_attrs %{absent: "some absent", present: "some present"}
    @update_attrs %{absent: "some updated absent", present: "some updated present"}
    @invalid_attrs %{absent: nil, present: nil}

    def discussion_fixture(attrs \\ %{}) do
      {:ok, discussion} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Discussions.create_discussion()

      discussion
    end

    test "list_discussions/0 returns all discussions" do
      discussion = discussion_fixture()
      assert Discussions.list_discussions() == [discussion]
    end

    test "get_discussion!/1 returns the discussion with given id" do
      discussion = discussion_fixture()
      assert Discussions.get_discussion!(discussion.id) == discussion
    end

    test "create_discussion/1 with valid data creates a discussion" do
      assert {:ok, %Discussion{} = discussion} = Discussions.create_discussion(@valid_attrs)
      assert discussion.absent == "some absent"
      assert discussion.present == "some present"
    end

    test "create_discussion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Discussions.create_discussion(@invalid_attrs)
    end

    test "update_discussion/2 with valid data updates the discussion" do
      discussion = discussion_fixture()
      assert {:ok, %Discussion{} = discussion} = Discussions.update_discussion(discussion, @update_attrs)
      assert discussion.absent == "some updated absent"
      assert discussion.present == "some updated present"
    end

    test "update_discussion/2 with invalid data returns error changeset" do
      discussion = discussion_fixture()
      assert {:error, %Ecto.Changeset{}} = Discussions.update_discussion(discussion, @invalid_attrs)
      assert discussion == Discussions.get_discussion!(discussion.id)
    end

    test "delete_discussion/1 deletes the discussion" do
      discussion = discussion_fixture()
      assert {:ok, %Discussion{}} = Discussions.delete_discussion(discussion)
      assert_raise Ecto.NoResultsError, fn -> Discussions.get_discussion!(discussion.id) end
    end

    test "change_discussion/1 returns a discussion changeset" do
      discussion = discussion_fixture()
      assert %Ecto.Changeset{} = Discussions.change_discussion(discussion)
    end
  end
end
