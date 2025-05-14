defmodule StudyWeb.Examples.SidebarLive.Index do
  use StudyWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, _params) do
    socket
    |> assign(:page_title, "Edit Sidebar")
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Sidebar")
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sidebar")
  end

  @impl true
  def handle_event("test_event", params, socket) do
    IO.inspect(params, label: "test_event: params =")
    {:noreply, socket}
  end
end
