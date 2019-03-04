defmodule VwStockWeb.InventoryController do
  use VwStockWeb, :controller

  alias VwStock.Dealers
  alias VwStock.Dealers.Inventory

  def show(conn, %{"dealer_id" => dealer_id, "id" => vin}) do
    inventory = Dealers.get_inventory!(vin)
    render(conn, "show.html", inventory: inventory)
  end

end
