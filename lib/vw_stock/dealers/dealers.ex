defmodule VwStock.Dealers do
  @moduledoc """
  The Dealers context.
  """

  import Ecto.Query, warn: false
  alias VwStock.Repo

  alias VwStock.Dealers.Dealer

  @doc """
  Returns the list of dealers.

  ## Examples

      iex> list_dealers()
      [%Dealer{}, ...]

  """
  def list_dealers do
    Repo.all(Dealer)
  end

  @doc """
  Gets a single dealer.

  Raises `Ecto.NoResultsError` if the Dealer does not exist.

  ## Examples

      iex> get_dealer!(123)
      %Dealer{}

      iex> get_dealer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dealer(id), do: Repo.get(Dealer, id)
  def get_dealer!(id), do: Repo.get!(Dealer, id)

  @doc """
  Creates a dealer.

  ## Examples

      iex> create_dealer(%{field: value})
      {:ok, %Dealer{}}

      iex> create_dealer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dealer(attrs \\ %{}) do
    %Dealer{}
    |> Dealer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dealer.

  ## Examples

      iex> update_dealer(dealer, %{field: new_value})
      {:ok, %Dealer{}}

      iex> update_dealer(dealer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dealer(%Dealer{} = dealer, attrs) do
    dealer
    |> Dealer.changeset(attrs)
    |> Repo.update()
  end


  @doc """
  Inserts or updates a dealer.

  ## Examples

      iex> update_dealer(dealer, %{field: new_value})
      {:ok, %Dealer{}}

      iex> update_dealer(dealer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def insert_or_update_dealer(%Dealer{id: id} = dealer) do
    case get_dealer(id) do
      nil -> Repo.insert(dealer)
      old_dealer = %Dealer{} ->
        params =
          dealer
          |> Map.drop([:__struct__, :__meta__])
          |> Stream.map(fn
            {key, val} when is_atom(key) -> {Atom.to_string(key), val}
            any -> any
          end)
          |> Enum.into(%{})

        update_dealer(old_dealer, params)
    end
  end




  @doc """
  Deletes a Dealer.

  ## Examples

      iex> delete_dealer(dealer)
      {:ok, %Dealer{}}

      iex> delete_dealer(dealer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dealer(%Dealer{} = dealer) do
    Repo.delete(dealer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dealer changes.

  ## Examples

      iex> change_dealer(dealer)
      %Ecto.Changeset{source: %Dealer{}}

  """
  def change_dealer(%Dealer{} = dealer) do
    Dealer.changeset(dealer, %{})
  end


  alias VwStock.Dealers.Inventory

  @doc """
  Returns the list of inventory.

  ## Examples

      iex> list_inventory()
      [%Inventory{}, ...]

  """
  def list_inventory do
    Repo.all(Inventory)
  end

  @doc """
  Gets a single inventory.

  Raises `Ecto.NoResultsError` if the Inventory does not exist.

  ## Examples

      iex> get_inventory!(123)
      %Inventory{}

      iex> get_inventory!(456)
      ** (Ecto.NoResultsError)

  """

  def get_inventory(dealer_id, vin), do: Repo.get_by(Inventory, dealer_id: dealer_id, vin: vin)
  def get_inventory!(dealer_id, vin), do: Repo.get_by!(Inventory, dealer_id: dealer_id, vin: vin)

  @doc """
  Creates a inventory.

  ## Examples

      iex> create_inventory(%{field: value})
      {:ok, %Inventory{}}

      iex> create_inventory(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_inventory(attrs \\ %{}) do
    %Inventory{}
    |> Inventory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a inventory.

  ## Examples

      iex> update_inventory(inventory, %{field: new_value})
      {:ok, %Inventory{}}

      iex> update_inventory(inventory, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_inventory(%Inventory{} = inventory, attrs) do
    inventory
    |> Inventory.changeset(attrs)
    |> Repo.update()
  end

  def insert_or_update_inventory(%Inventory{dealer_id: id, vin: vin} = inventory) do
    case get_inventory(id, vin) do
      nil -> Repo.insert(inventory)
      old_inventory = %Inventory{} ->
        params =
          inventory
          |> Map.drop([:__struct__, :__meta__])
          |> Stream.map(fn
            {key, val} when is_atom(key) -> {Atom.to_string(key), val}
            any -> any
          end)
          |> Enum.into(%{})

        update_inventory(old_inventory, params)
    end
  end

  @doc """
  Deletes a Inventory.

  ## Examples

      iex> delete_inventory(inventory)
      {:ok, %Inventory{}}

      iex> delete_inventory(inventory)
      {:error, %Ecto.Changeset{}}

  """
  def delete_inventory(%Inventory{} = inventory) do
    Repo.delete(inventory)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking inventory changes.

  ## Examples

      iex> change_inventory(inventory)
      %Ecto.Changeset{source: %Inventory{}}

  """
  def change_inventory(%Inventory{} = inventory) do
    Inventory.changeset(inventory, %{})
  end
end
