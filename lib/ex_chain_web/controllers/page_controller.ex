defmodule ExChainWeb.PageController do
  use ExChainWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
