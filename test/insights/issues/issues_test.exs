defmodule Insights.IssuesTest do
  use Insights.DataCase

  alias Insights.Issues

  describe "issues" do
    alias Insights.Issues.Issue

    @valid_attrs %{appropriations: 42, description: "some description", identifier: "some identifier", importance: 120.5, status: "some status", urls: "some urls"}
    @update_attrs %{appropriations: 43, description: "some updated description", identifier: "some updated identifier", importance: 456.7, status: "some updated status", urls: "some updated urls"}
    @invalid_attrs %{appropriations: nil, description: nil, identifier: nil, importance: nil, status: nil, urls: nil}

    def issue_fixture(attrs \\ %{}) do
      {:ok, issue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Issues.create_issue()

      issue
    end

    test "list_issues/0 returns all issues" do
      issue = issue_fixture()
      assert Issues.list_issues() == [issue]
    end

    test "get_issue!/1 returns the issue with given id" do
      issue = issue_fixture()
      assert Issues.get_issue!(issue.id) == issue
    end

    test "create_issue/1 with valid data creates a issue" do
      assert {:ok, %Issue{} = issue} = Issues.create_issue(@valid_attrs)
      assert issue.appropriations == 42
      assert issue.description == "some description"
      assert issue.identifier == "some identifier"
      assert issue.importance == 120.5
      assert issue.status == "some status"
      assert issue.urls == "some urls"
    end

    test "create_issue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Issues.create_issue(@invalid_attrs)
    end

    test "update_issue/2 with valid data updates the issue" do
      issue = issue_fixture()
      assert {:ok, %Issue{} = issue} = Issues.update_issue(issue, @update_attrs)
      assert issue.appropriations == 43
      assert issue.description == "some updated description"
      assert issue.identifier == "some updated identifier"
      assert issue.importance == 456.7
      assert issue.status == "some updated status"
      assert issue.urls == "some updated urls"
    end

    test "update_issue/2 with invalid data returns error changeset" do
      issue = issue_fixture()
      assert {:error, %Ecto.Changeset{}} = Issues.update_issue(issue, @invalid_attrs)
      assert issue == Issues.get_issue!(issue.id)
    end

    test "delete_issue/1 deletes the issue" do
      issue = issue_fixture()
      assert {:ok, %Issue{}} = Issues.delete_issue(issue)
      assert_raise Ecto.NoResultsError, fn -> Issues.get_issue!(issue.id) end
    end

    test "change_issue/1 returns a issue changeset" do
      issue = issue_fixture()
      assert %Ecto.Changeset{} = Issues.change_issue(issue)
    end
  end
end
