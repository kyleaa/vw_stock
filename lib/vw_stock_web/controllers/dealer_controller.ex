defmodule VwStockWeb.DealerController do
  use VwStockWeb, :controller

  alias VwStock.Dealers
  alias VwStock.Dealers.Dealer

  def index(conn, _params) do
    dealers = Dealers.list_dealers()
    render(conn, "index.html", dealers: dealers)
  end

  def map(conn, _params) do
    dealers = Dealers.list_dealers()
    render(conn, "map.html", dealers: dealers)
  end

  def create(conn, %{"import_zip" => %{ "import_zip" => zip }}) do
    dealers = VwStock.VwApi.fetch_dealers_by_zip(zip)
    |> Enum.each(fn dealer ->
      Dealers.insert_or_update_dealer(dealer)
    end)

    conn
    |> put_flash(:info, "Import completed successfully.")
    |> redirect(to: dealer_path(conn, :index))
  end

  def show(conn, %{"id" => id}) do
    dealer = Dealers.get_dealer!(id)
    render(conn, "show.html", dealer: dealer)
  end

  def delete(conn, %{"id" => id}) do
    dealer = Dealers.get_dealer!(id)
    {:ok, _dealer} = Dealers.delete_dealer(dealer)

    conn
    |> put_flash(:info, "Dealer deleted successfully.")
    |> redirect(to: dealer_path(conn, :index))
  end
end
