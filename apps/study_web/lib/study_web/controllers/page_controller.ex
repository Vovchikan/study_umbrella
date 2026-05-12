defmodule StudyWeb.PageController do
  use StudyWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
