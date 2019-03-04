defmodule VwStockWeb.InventoryControllerTest do
  use VwStockWeb.ConnCase

  alias VwStock.Dealers

  @create_attrs %{dealer_id: 42, raw_json: %{}, vin: "some vin"}
  @update_attrs %{dealer_id: 43, raw_json: %{}, vin: "some updated vin"}
  @invalid_attrs %{dealer_id: nil, raw_json: nil, vin: nil}

  def fixture(:inventory) do
    {:ok, inventory} = Dealers.create_inventory(@create_attrs)
    inventory
  end

  describe "index" do
    test "lists all inventory", %{conn: conn} do
      conn = get conn, inventory_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Inventory"
    end
  end

  describe "new inventory" do
    test "renders form", %{conn: conn} do
      conn = get conn, inventory_path(conn, :new)
      assert html_response(conn, 200) =~ "New Inventory"
    end
  end

  describe "create inventory" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, inventory_path(conn, :create), inventory: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == inventory_path(conn, :show, id)

      conn = get conn, inventory_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Inventory"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, inventory_path(conn, :create), inventory: @invalid_attrs
      assert html_response(conn, 200) =~ "New Inventory"
    end
  end

  describe "edit inventory" do
    setup [:create_inventory]

    test "renders form for editing chosen inventory", %{conn: conn, inventory: inventory} do
      conn = get conn, inventory_path(conn, :edit, inventory)
      assert html_response(conn, 200) =~ "Edit Inventory"
    end
  end

  describe "update inventory" do
    setup [:create_inventory]

    test "redirects when data is valid", %{conn: conn, inventory: inventory} do
      conn = put conn, inventory_path(conn, :update, inventory), inventory: @update_attrs
      assert redirected_to(conn) == inventory_path(conn, :show, inventory)

      conn = get conn, inventory_path(conn, :show, inventory)
      assert html_response(conn, 200) =~ "some updated vin"
    end

    test "renders errors when data is invalid", %{conn: conn, inventory: inventory} do
      conn = put conn, inventory_path(conn, :update, inventory), inventory: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Inventory"
    end
  end

  describe "delete inventory" do
    setup [:create_inventory]

    test "deletes chosen inventory", %{conn: conn, inventory: inventory} do
      conn = delete conn, inventory_path(conn, :delete, inventory)
      assert redirected_to(conn) == inventory_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, inventory_path(conn, :show, inventory)
      end
    end
  end

  defp create_inventory(_) do
    inventory = fixture(:inventory)
    {:ok, inventory: inventory}
  end
end
