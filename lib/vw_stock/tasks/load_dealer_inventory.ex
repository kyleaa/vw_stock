defmodule VwStock.Tasks.LoadDealerInventory do
  alias VwStock.VwApi, as: API
  alias VwStock.Dealers
  alias VwStock.Dealers.Dealer

  def reload_inventory_for_dealer(dealer_id) do
    batch_ts = :os.system_time(:seconds)

    with dealer = %Dealer{} <- Dealers.get_dealer(dealer_id) do
      API.fetch_dealer_inventory(dealer_id)
      |> Stream.map(&(Map.put(&1, :update_batch_ts, batch_ts)))
      |> Enum.each(&Dealers.insert_or_update_inventory/1)

      {:ok, _dealer} = Dealers.update_dealer(dealer, %{update_batch_ts: batch_ts})
    end
  end

  def reload_all_dealers do
    Dealers.list_dealers
    |> Enum.each(fn %Dealer{id: id} -> reload_inventory_for_dealer(id) end)
  end

end
