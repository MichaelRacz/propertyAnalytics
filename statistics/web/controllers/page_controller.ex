defmodule Statistics.PageController do
  use Statistics.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
