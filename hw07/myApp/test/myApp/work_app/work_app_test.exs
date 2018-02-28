defmodule MyApp.Work_appTest do
  use MyApp.DataCase

  alias MyApp.Work_app

  describe "works" do
    alias MyApp.Work_app.Work

    @valid_attrs %{assigned_by: "some assigned_by", done: true, done_time: ~T[14:00:00.000000], task_body: "some task_body", task_title: "some task_title"}
    @update_attrs %{assigned_by: "some updated assigned_by", done: false, done_time: ~T[15:01:01.000000], task_body: "some updated task_body", task_title: "some updated task_title"}
    @invalid_attrs %{assigned_by: nil, done: nil, done_time: nil, task_body: nil, task_title: nil}

    def work_fixture(attrs \\ %{}) do
      {:ok, work} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Work_app.create_work()

      work
    end

    test "list_works/0 returns all works" do
      work = work_fixture()
      assert Work_app.list_works() == [work]
    end

    test "get_work!/1 returns the work with given id" do
      work = work_fixture()
      assert Work_app.get_work!(work.id) == work
    end

    test "create_work/1 with valid data creates a work" do
      assert {:ok, %Work{} = work} = Work_app.create_work(@valid_attrs)
      assert work.assigned_by == "some assigned_by"
      assert work.done == true
      assert work.done_time == ~T[14:00:00.000000]
      assert work.task_body == "some task_body"
      assert work.task_title == "some task_title"
    end

    test "create_work/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Work_app.create_work(@invalid_attrs)
    end

    test "update_work/2 with valid data updates the work" do
      work = work_fixture()
      assert {:ok, work} = Work_app.update_work(work, @update_attrs)
      assert %Work{} = work
      assert work.assigned_by == "some updated assigned_by"
      assert work.done == false
      assert work.done_time == ~T[15:01:01.000000]
      assert work.task_body == "some updated task_body"
      assert work.task_title == "some updated task_title"
    end

    test "update_work/2 with invalid data returns error changeset" do
      work = work_fixture()
      assert {:error, %Ecto.Changeset{}} = Work_app.update_work(work, @invalid_attrs)
      assert work == Work_app.get_work!(work.id)
    end

    test "delete_work/1 deletes the work" do
      work = work_fixture()
      assert {:ok, %Work{}} = Work_app.delete_work(work)
      assert_raise Ecto.NoResultsError, fn -> Work_app.get_work!(work.id) end
    end

    test "change_work/1 returns a work changeset" do
      work = work_fixture()
      assert %Ecto.Changeset{} = Work_app.change_work(work)
    end
  end

  describe "durations" do
    alias MyApp.Work_app.Duration

    @valid_attrs %{end_time: ~N[2010-04-17 14:00:00.000000], start_time: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{end_time: ~N[2011-05-18 15:01:01.000000], start_time: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{end_time: nil, start_time: nil}

    def duration_fixture(attrs \\ %{}) do
      {:ok, duration} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Work_app.create_duration()

      duration
    end

    test "list_durations/0 returns all durations" do
      duration = duration_fixture()
      assert Work_app.list_durations() == [duration]
    end

    test "get_duration!/1 returns the duration with given id" do
      duration = duration_fixture()
      assert Work_app.get_duration!(duration.id) == duration
    end

    test "create_duration/1 with valid data creates a duration" do
      assert {:ok, %Duration{} = duration} = Work_app.create_duration(@valid_attrs)
      assert duration.end_time == ~N[2010-04-17 14:00:00.000000]
      assert duration.start_time == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_duration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Work_app.create_duration(@invalid_attrs)
    end

    test "update_duration/2 with valid data updates the duration" do
      duration = duration_fixture()
      assert {:ok, duration} = Work_app.update_duration(duration, @update_attrs)
      assert %Duration{} = duration
      assert duration.end_time == ~N[2011-05-18 15:01:01.000000]
      assert duration.start_time == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_duration/2 with invalid data returns error changeset" do
      duration = duration_fixture()
      assert {:error, %Ecto.Changeset{}} = Work_app.update_duration(duration, @invalid_attrs)
      assert duration == Work_app.get_duration!(duration.id)
    end

    test "delete_duration/1 deletes the duration" do
      duration = duration_fixture()
      assert {:ok, %Duration{}} = Work_app.delete_duration(duration)
      assert_raise Ecto.NoResultsError, fn -> Work_app.get_duration!(duration.id) end
    end

    test "change_duration/1 returns a duration changeset" do
      duration = duration_fixture()
      assert %Ecto.Changeset{} = Work_app.change_duration(duration)
    end
  end
end
