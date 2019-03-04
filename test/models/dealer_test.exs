defmodule VwStock.DealerTest do
  use VwStock.ModelCase

  alias VwStock.Dealer

  @valid_attrs %{address1: "some address1", address2: "some address2", city: "some city", latlong: "some latlong", name: "some name", postalcode: "some postalcode", raw_json: %{}, state: "some state", url: "some url"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Dealer.changeset(%Dealer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Dealer.changeset(%Dealer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
