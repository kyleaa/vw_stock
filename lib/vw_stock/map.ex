defmodule VwStock.Map do
  def api_key, do: Application.get_env(:vw_stock, __MODULE__)[:api_key]
end
