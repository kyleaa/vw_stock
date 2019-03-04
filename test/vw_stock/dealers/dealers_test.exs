defmodule VwStock.DealersTest do
  use VwStock.DataCase

  alias VwStock.Dealers

  describe "dealers" do
    alias VwStock.Dealers.Dealer

    @valid_attrs %{address1: "some address1", address2: "some address2", city: "some city", latlong: "some latlong", name: "some name", postalcode: "some postalcode", raw_json: %{}, state: "some state", url: "some url"}
    @update_attrs %{address1: "some updated address1", address2: "some updated address2", city: "some updated city", latlong: "some updated latlong", name: "some updated name", postalcode: "some updated postalcode", raw_json: %{}, state: "some updated state", url: "some updated url"}
    @invalid_attrs %{address1: nil, address2: nil, city: nil, latlong: nil, name: nil, postalcode: nil, raw_json: nil, state: nil, url: nil}

    def dealer_fixture(attrs \\ %{}) do
      {:ok, dealer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dealers.create_dealer()

      dealer
    end

    test "list_dealers/0 returns all dealers" do
      dealer = dealer_fixture()
      assert Dealers.list_dealers() == [dealer]
    end

    test "get_dealer!/1 returns the dealer with given id" do
      dealer = dealer_fixture()
      assert Dealers.get_dealer!(dealer.id) == dealer
    end

    test "create_dealer/1 with valid data creates a dealer" do
      assert {:ok, %Dealer{} = dealer} = Dealers.create_dealer(@valid_attrs)
      assert dealer.address1 == "some address1"
      assert dealer.address2 == "some address2"
      assert dealer.city == "some city"
      assert dealer.latlong == "some latlong"
      assert dealer.name == "some name"
      assert dealer.postalcode == "some postalcode"
      assert dealer.raw_json == %{}
      assert dealer.state == "some state"
      assert dealer.url == "some url"
    end

    test "create_dealer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dealers.create_dealer(@invalid_attrs)
    end

    test "update_dealer/2 with valid data updates the dealer" do
      dealer = dealer_fixture()
      assert {:ok, dealer} = Dealers.update_dealer(dealer, @update_attrs)
      assert %Dealer{} = dealer
      assert dealer.address1 == "some updated address1"
      assert dealer.address2 == "some updated address2"
      assert dealer.city == "some updated city"
      assert dealer.latlong == "some updated latlong"
      assert dealer.name == "some updated name"
      assert dealer.postalcode == "some updated postalcode"
      assert dealer.raw_json == %{}
      assert dealer.state == "some updated state"
      assert dealer.url == "some updated url"
    end

    test "update_dealer/2 with invalid data returns error changeset" do
      dealer = dealer_fixture()
      assert {:error, %Ecto.Changeset{}} = Dealers.update_dealer(dealer, @invalid_attrs)
      assert dealer == Dealers.get_dealer!(dealer.id)
    end

    test "delete_dealer/1 deletes the dealer" do
      dealer = dealer_fixture()
      assert {:ok, %Dealer{}} = Dealers.delete_dealer(dealer)
      assert_raise Ecto.NoResultsError, fn -> Dealers.get_dealer!(dealer.id) end
    end

    test "change_dealer/1 returns a dealer changeset" do
      dealer = dealer_fixture()
      assert %Ecto.Changeset{} = Dealers.change_dealer(dealer)
    end
  end

  describe "inventory" do
    alias VwStock.Dealers.Inventory

    @valid_attrs %{dealer_id: 42, raw_json: %{}, vin: "some vin"}
    @update_attrs %{dealer_id: 43, raw_json: %{}, vin: "some updated vin"}
    @invalid_attrs %{dealer_id: nil, raw_json: nil, vin: nil}

    def inventory_fixture(attrs \\ %{}) do
      {:ok, inventory} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dealers.create_inventory()

      inventory
    end

    test "list_inventory/0 returns all inventory" do
      inventory = inventory_fixture()
      assert Dealers.list_inventory() == [inventory]
    end

    test "get_inventory!/1 returns the inventory with given id" do
      inventory = inventory_fixture()
      assert Dealers.get_inventory!(inventory.id) == inventory
    end

    test "create_inventory/1 with valid data creates a inventory" do
      assert {:ok, %Inventory{} = inventory} = Dealers.create_inventory(@valid_attrs)
      assert inventory.dealer_id == 42
      assert inventory.raw_json == %{}
      assert inventory.vin == "some vin"
    end

    test "create_inventory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dealers.create_inventory(@invalid_attrs)
    end

    test "update_inventory/2 with valid data updates the inventory" do
      inventory = inventory_fixture()
      assert {:ok, inventory} = Dealers.update_inventory(inventory, @update_attrs)
      assert %Inventory{} = inventory
      assert inventory.dealer_id == 43
      assert inventory.raw_json == %{}
      assert inventory.vin == "some updated vin"
    end

    test "update_inventory/2 with invalid data returns error changeset" do
      inventory = inventory_fixture()
      assert {:error, %Ecto.Changeset{}} = Dealers.update_inventory(inventory, @invalid_attrs)
      assert inventory == Dealers.get_inventory!(inventory.id)
    end

    test "delete_inventory/1 deletes the inventory" do
      inventory = inventory_fixture()
      assert {:ok, %Inventory{}} = Dealers.delete_inventory(inventory)
      assert_raise Ecto.NoResultsError, fn -> Dealers.get_inventory!(inventory.id) end
    end

    test "change_inventory/1 returns a inventory changeset" do
      inventory = inventory_fixture()
      assert %Ecto.Changeset{} = Dealers.change_inventory(inventory)
    end
  end
end
