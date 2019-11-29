defmodule ChatterWeb.ToDoListLive do
  use Phoenix.LiveView
  alias ChatterWeb.ToDoListView

  alias Chatter.ToDoList
  alias Chatter.ToDoList.Task

  @topic "tasks"

  def mount(_session, socket) do
    if connected?(socket), do: ChatterWeb.Endpoint.subscribe(@topic)

    {:ok,
     assign(socket, %{
       tasks: ToDoList.list_tasks(),
       changeset: ToDoList.change_task(%Task{})
     })}
  end

  def handle_event("send_task", %{"task" => params}, socket) do
    case ToDoList.create_task(params) do
      {:ok, _task} ->
        {:noreply,
         assign(socket, %{
           tasks: ToDoList.list_tasks(),
           changeset: ToDoList.change_task(%Task{})
         })}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def render(assigns) do
    ToDoListView.render("index.html", assigns)
  end
end
