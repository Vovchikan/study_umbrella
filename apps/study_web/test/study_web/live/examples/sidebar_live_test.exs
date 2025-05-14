defmodule StudyWeb.Examples.SidebarLiveTest do
  use StudyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Study.ExamplesFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_sidebar(_) do
    sidebar = sidebar_fixture()
    %{sidebar: sidebar}
  end

  describe "Index" do
    setup [:create_sidebar]

    test "lists all sidebar", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/examples/sidebar")

      assert html =~ "Listing Sidebar"
    end

    test "saves new sidebar", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/examples/sidebar")

      assert index_live |> element("a", "New Sidebar") |> render_click() =~
               "New Sidebar"

      assert_patch(index_live, ~p"/examples/sidebar/new")

      assert index_live
             |> form("#sidebar-form", sidebar: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#sidebar-form", sidebar: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/examples/sidebar")

      html = render(index_live)
      assert html =~ "Sidebar created successfully"
    end

    test "updates sidebar in listing", %{conn: conn, sidebar: sidebar} do
      {:ok, index_live, _html} = live(conn, ~p"/examples/sidebar")

      assert index_live |> element("#sidebar-#{sidebar.id} a", "Edit") |> render_click() =~
               "Edit Sidebar"

      assert_patch(index_live, ~p"/examples/sidebar/#{sidebar}/edit")

      assert index_live
             |> form("#sidebar-form", sidebar: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#sidebar-form", sidebar: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/examples/sidebar")

      html = render(index_live)
      assert html =~ "Sidebar updated successfully"
    end

    test "deletes sidebar in listing", %{conn: conn, sidebar: sidebar} do
      {:ok, index_live, _html} = live(conn, ~p"/examples/sidebar")

      assert index_live |> element("#sidebar-#{sidebar.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#sidebar-#{sidebar.id}")
    end
  end

  describe "Show" do
    setup [:create_sidebar]

    test "displays sidebar", %{conn: conn, sidebar: sidebar} do
      {:ok, _show_live, html} = live(conn, ~p"/examples/sidebar/#{sidebar}")

      assert html =~ "Show Sidebar"
    end

    test "updates sidebar within modal", %{conn: conn, sidebar: sidebar} do
      {:ok, show_live, _html} = live(conn, ~p"/examples/sidebar/#{sidebar}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Sidebar"

      assert_patch(show_live, ~p"/examples/sidebar/#{sidebar}/show/edit")

      assert show_live
             |> form("#sidebar-form", sidebar: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#sidebar-form", sidebar: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/examples/sidebar/#{sidebar}")

      html = render(show_live)
      assert html =~ "Sidebar updated successfully"
    end
  end
end
