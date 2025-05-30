defmodule StudyWeb.Examples.SidebarLive.Index do
  use StudyWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    items = [
      %{
        id: 1,
        title: "Famous Quote",
        items: [%{id: 4, title: "Settings", href: ~p"/users/settings"}]
      },
      %{id: 2, title: "UK Saying", items: []},
      %{id: 3, title: "I know...", items: []}
    ]

    {:ok, socket |> assign(items: items)}
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
