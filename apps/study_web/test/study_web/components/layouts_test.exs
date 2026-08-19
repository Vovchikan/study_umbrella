defmodule StudyWeb.LayoutsTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest

  test "by default does not auto-dismiss any flash" do
    original = Application.get_env(:study_web, :flash)

    on_exit(fn ->
      if original do
        Application.put_env(:study_web, :flash, original)
      else
        Application.delete_env(:study_web, :flash)
      end
    end)

    Application.put_env(:study_web, :flash, auto_dismiss: %{})

    html =
      render_component(&StudyWeb.Layouts.flash_group/1,
        flash: %{"info" => "Saved", "error" => "Failed"}
      )

    document = LazyHTML.from_fragment(html)
    hook = "StudyWeb.CoreComponents.AutoDismissFlash"

    for kind <- ~w(info error) do
      assert Enum.count(
               LazyHTML.query(
                 document,
                 ~s|#flash-#{kind}[phx-hook="#{hook}"]:not([data-timeout])|
               )
             ) == 1
    end
  end

  test "auto-dismiss timeouts from config (Format B)" do
    original = Application.get_env(:study_web, :flash)

    on_exit(fn ->
      if original do
        Application.put_env(:study_web, :flash, original)
      else
        Application.delete_env(:study_web, :flash)
      end
    end)

    Application.put_env(:study_web, :flash, auto_dismiss: %{info: 5_000, error: 3_000})

    html =
      render_component(&StudyWeb.Layouts.flash_group/1,
        flash: %{"info" => "Saved", "error" => "Failed"}
      )

    document = LazyHTML.from_fragment(html)
    hook = "StudyWeb.CoreComponents.AutoDismissFlash"

    assert Enum.count(
             LazyHTML.query(document, ~s|#flash-info[phx-hook="#{hook}"][data-timeout="5000"]|)
           ) == 1

    assert Enum.count(
             LazyHTML.query(document, ~s|#flash-error[phx-hook="#{hook}"][data-timeout="3000"]|)
           ) == 1
  end

  test "HEEx timeouts attribute overrides config" do
    html =
      render_component(&StudyWeb.Layouts.flash_group/1,
        flash: %{"info" => "Saved", "error" => "Failed"},
        timeouts: %{info: 9_999, error: 8_888}
      )

    document = LazyHTML.from_fragment(html)
    hook = "StudyWeb.CoreComponents.AutoDismissFlash"

    assert Enum.count(
             LazyHTML.query(document, ~s|#flash-info[phx-hook="#{hook}"][data-timeout="9999"]|)
           ) == 1

    assert Enum.count(
             LazyHTML.query(document, ~s|#flash-error[phx-hook="#{hook}"][data-timeout="8888"]|)
           ) == 1
  end
end
