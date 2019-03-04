defmodule VwStockWeb.DealerControllerTest do
  use VwStockWeb.ConnCase

  alias VwStock.Dealers

  @create_attrs %{address1: "some address1", address2: "some address2", city: "some city", latlong: "some latlong", name: "some name", postalcode: "some postalcode", raw_json: %{}, state: "some state", url: "some url"}
  @update_attrs %{address1: "some updated address1", address2: "some updated address2", city: "some updated city", latlong: "some updated latlong", name: "some updated name", postalcode: "some updated postalcode", raw_json: %{}, state: "some updated state", url: "some updated url"}
  @invalid_attrs %{address1: nil, address2: nil, city: nil, latlong: nil, name: nil, postalcode: nil, raw_json: nil, state: nil, url: nil}

  def fixture(:dealer) do
    {:ok, dealer} = Dealers.create_dealer(@create_attrs)
    dealer
  end

  describe "index" do
    test "lists all dealers", %{conn: conn} do
      conn = get conn, dealer_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Dealers"
    end
  end

  describe "new dealer" do
    test "renders form", %{conn: conn} do
      conn = get conn, dealer_path(conn, :new)
      assert html_response(conn, 200) =~ "New Dealer"
    end
  end

  describe "create dealer" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, dealer_path(conn, :create), dealer: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == dealer_path(conn, :show, id)

      conn = get conn, dealer_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Dealer"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, dealer_path(conn, :create), dealer: @invalid_attrs
      assert html_response(conn, 200) =~ "New Dealer"
    end
  end

  describe "edit dealer" do
    setup [:create_dealer]

    test "renders form for editing chosen dealer", %{conn: conn, dealer: dealer} do
      conn = get conn, dealer_path(conn, :edit, dealer)
      assert html_response(conn, 200) =~ "Edit Dealer"
    end
  end

  describe "update dealer" do
    setup [:create_dealer]

    test "redirects when data is valid", %{conn: conn, dealer: dealer} do
      conn = put conn, dealer_path(conn, :update, dealer), dealer: @update_attrs
      assert redirected_to(conn) == dealer_path(conn, :show, dealer)

      conn = get conn, dealer_path(conn, :show, dealer)
      assert html_response(conn, 200) =~ "some updated address1"
    end

    test "renders errors when data is invalid", %{conn: conn, dealer: dealer} do
      conn = put conn, dealer_path(conn, :update, dealer), dealer: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Dealer"
    end
  end

  describe "delete dealer" do
    setup [:create_dealer]

    test "deletes chosen dealer", %{conn: conn, dealer: dealer} do
      conn = delete conn, dealer_path(conn, :delete, dealer)
      assert redirected_to(conn) == dealer_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, dealer_path(conn, :show, dealer)
      end
    end
  end

  defp create_dealer(_) do
    dealer = fixture(:dealer)
    {:ok, dealer: dealer}
  end
end
