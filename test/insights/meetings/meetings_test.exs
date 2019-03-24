defmodule Insights.MeetingsTest do
  use Insights.DataCase

  alias Insights.Meetings

  describe "meetings" do
    alias Insights.Meetings.Meeting

    @valid_attrs %{
      body: "some body",
      date: ~D[2010-04-17],
      minutes_url: "some minutes_url",
      agenda_url: "some agenda_url"
    }
    @update_attrs %{
      body: "some updated body",
      date: ~D[2011-05-18],
      minutes_url: "some updated minutes_url",
      agenda_url: "some updated agenda_url"
    }
    @invalid_attrs %{body: nil, date: nil, minutes_url: nil, agenda_url: nil}

    def meeting_fixture(attrs \\ %{}) do
      {:ok, meeting} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Meetings.create_meeting()

      meeting
    end

    test "list_meetings/0 returns all meetings" do
      meeting = meeting_fixture()
      assert Meetings.list_meetings() == [meeting]
    end

    test "get_meeting!/1 returns the meeting with given id" do
      meeting = meeting_fixture()
      assert Meetings.get_meeting!(meeting.id) == meeting
    end

    test "create_meeting/1 with valid data creates a meeting" do
      assert {:ok, %Meeting{} = meeting} = Meetings.create_meeting(@valid_attrs)
      assert meeting.body == "some body"
      assert meeting.date == ~D[2010-04-17]
      assert meeting.minutes_url == "some minutes_url"
      assert meeting.agenda_url == "some agenda_url"
    end

    test "create_meeting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Meetings.create_meeting(@invalid_attrs)
    end

    test "update_meeting/2 with valid data updates the meeting" do
      meeting = meeting_fixture()
      assert {:ok, %Meeting{} = meeting} = Meetings.update_meeting(meeting, @update_attrs)
      assert meeting.body == "some updated body"
      assert meeting.date == ~D[2011-05-18]
      assert meeting.minutes_url == "some updated minutes_url"
      assert meeting.agenda_url == "some updated agenda_url"
    end

    test "update_meeting/2 with invalid data returns error changeset" do
      meeting = meeting_fixture()
      assert {:error, %Ecto.Changeset{}} = Meetings.update_meeting(meeting, @invalid_attrs)
      assert meeting == Meetings.get_meeting!(meeting.id)
    end

    test "delete_meeting/1 deletes the meeting" do
      meeting = meeting_fixture()
      assert {:ok, %Meeting{}} = Meetings.delete_meeting(meeting)
      assert_raise Ecto.NoResultsError, fn -> Meetings.get_meeting!(meeting.id) end
    end

    test "change_meeting/1 returns a meeting changeset" do
      meeting = meeting_fixture()
      assert %Ecto.Changeset{} = Meetings.change_meeting(meeting)
    end
  end
end
