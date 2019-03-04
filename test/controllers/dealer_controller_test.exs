defmodule VwStock.DealerControllerTest do
  use VwStock.ConnCase

  alias VwStock.Dealer
  @valid_attrs %{address1: "some address1", address2: "some address2", city: "some city", latlong: "some latlong", name: "some name", postalcode: "some postalcode", raw_json: %{}, state: "some state", url: "some url"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, dealer_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing dealers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, dealer_path(conn, :new)
    assert html_response(conn, 200) =~ "New dealer"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, dealer_path(conn, :create), dealer: @valid_attrs
    dealer = Repo.get_by!(Dealer, @valid_attrs)
    assert redirected_to(conn) == dealer_path(conn, :show, dealer.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, dealer_path(conn, :create), dealer: @invalid_attrs
    assert html_response(conn, 200) =~ "New dealer"
  end

  test "shows chosen resource", %{conn: conn} do
    dealer = Repo.insert! %Dealer{}
    conn = get conn, dealer_path(conn, :show, dealer)
    assert html_response(conn, 200) =~ "Show dealer"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, dealer_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    dealer = Repo.insert! %Dealer{}
    conn = get conn, dealer_path(conn, :edit, dealer)
    assert html_response(conn, 200) =~ "Edit dealer"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    dealer = Repo.insert! %Dealer{}
    conn = put conn, dealer_path(conn, :update, dealer), dealer: @valid_attrs
    assert redirected_to(conn) == dealer_path(conn, :show, dealer)
    assert Repo.get_by(Dealer, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    dealer = Repo.insert! %Dealer{}
    conn = put conn, dealer_path(conn, :update, dealer), dealer: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit dealer"
  end

  test "deletes chosen resource", %{conn: conn} do
    dealer = Repo.insert! %Dealer{}
    conn = delete conn, dealer_path(conn, :delete, dealer)
    assert redirected_to(conn) == dealer_path(conn, :index)
    refute Repo.get(Dealer, dealer.id)
  end
end
