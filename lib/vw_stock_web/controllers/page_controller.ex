defmodule VwStockWeb.PageController do
  use VwStockWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
