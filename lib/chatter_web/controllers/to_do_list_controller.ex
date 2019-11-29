defmodule ChatterWeb.ToDoListController do
  use ChatterWeb, :controller

  def index(conn, _params) do
    Phoenix.LiveView.Controller.live_render(conn, ChatterWeb.ToDoListLive, session: %{})
  end
end
