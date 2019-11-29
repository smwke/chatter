defmodule Chatter.ToDoList.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :done, :boolean, default: false
    field :title, :string
    field :user, :string
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:content, :title, :user, :done])
    |> validate_required([:content, :title, :user, :done])
  end
end
