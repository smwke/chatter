defmodule Chatter.ToDoListTest do
  use Chatter.DataCase

  alias Chatter.ToDoList

  describe "tasks" do
    alias Chatter.ToDoList.Task

    @valid_attrs %{done: true, title: "some title", user: "some user"}
    @update_attrs %{done: false, title: "some updated title", user: "some updated user"}
    @invalid_attrs %{done: nil, title: nil, user: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ToDoList.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert ToDoList.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert ToDoList.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = ToDoList.create_task(@valid_attrs)
      assert task.done == true
      assert task.title == "some title"
      assert task.user == "some user"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ToDoList.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = ToDoList.update_task(task, @update_attrs)
      assert task.done == false
      assert task.title == "some updated title"
      assert task.user == "some updated user"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = ToDoList.update_task(task, @invalid_attrs)
      assert task == ToDoList.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = ToDoList.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> ToDoList.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = ToDoList.change_task(task)
    end
  end
end
