defmodule VwStock.VwApi do
  @api_base "https://www.vw.com/vwsdl/rest/product/dealers/"

  def fetch_dealer_inventory(id) do
    "#{@api_base}inventory/#{id}.json"
    |> HTTPoison.get!
    |> Map.get(:body)
    |> Poison.decode!
    |> Enum.map(fn item ->
      %VwStock.Dealers.Inventory{}
      |> Map.put(:raw_json, item)
      |> Map.put(:dealer_id, id)
      |> Map.put(:vin, item["id"])
    end)
  end

  def fetch_dealers_by_zip(zip) do
    "#{@api_base}zip/#{zip}.json"
    |> HTTPoison.get!
    |> Map.get(:body)
    |> Poison.decode!
    |> Map.get("dealers")
    |> Enum.map(fn item ->
      %VwStock.Dealers.Dealer{}
      |> Map.merge(item)
      |> Map.put(:raw_json, item)
      |> Map.put(:id, extract_id(item, "dealerid"))
    end)
  end

  defp item_to_struct(item, struct, id_field) do
    Map.merge(struct, item)
    |> Map.put(:raw_json, item)
    |> Map.put(:id, extract_id(item, id_field))
  end

  def extract_id(map, key) do
    map
    |> Map.get(key)
    |> String.to_integer
  end

end
