alias VwStock.Dealers.Dealer
require Logger

home = {-115.3421553, 36.3106291}

VwStock.Dealers.list_dealers
|> Enum.each(fn dealer ->
  Logger.debug "updating #{dealer.id}"
  distance = Dealer.distance_to(dealer, home)
  VwStock.Dealers.update_dealer(dealer, %{distance: distance})
end)
