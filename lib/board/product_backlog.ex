defmodule Board.ProductBacklogs do
  @moduledoc """
  The ProductBacklogs context.
  """
  
  @behaviour Bodyguard.Policy
  
  import Ecto.Query, warn: false
  alias Board.Repo
  
  alias Board.Accounts.User
  alias Board.Products.Product
  alias Board.ProductBacklogs.BacklogItem
  
  def authorize(:delete_backlog_item, %User{id: user_id}, %Product{id: product_id}) do
    Repo.one(
    from(p in Product,
    join: u in assoc(p, :users),
    where: u.id == ^user_id and p.id == ^product_id)
    )
    |> case do
      nil -> :false
      _ -> :ok
    end
  end
  
  def authorize(_, _, _), do: false
  
  @doc """
  Returns the list of backlog_items.
  
  ## Examples
  
  iex> list_backlog_items()
  [%BacklogItem{}, ...]
  
  """
  def list_backlog_items do
    Repo.all(BacklogItem)
  end
  
  def list_backlog_items(product_id) do
    query = from(b in BacklogItem,
    where: b.product_id == ^product_id,
    order_by: b.order)
    
    Repo.all(query)
  end
  
  def get_backlog_item(id), do: Repo.get(BacklogItem, id)
  
  @doc """
  Gets a single backlog_item.
  
  Raises `Ecto.NoResultsError` if the Backlog item does not exist.
  
  ## Examples
  
  iex> get_backlog_item!(123)
  %BacklogItem{}
  
  iex> get_backlog_item!(456)
  ** (Ecto.NoResultsError)
  
  """
  def get_backlog_item!(id), do: Repo.get!(BacklogItem, id)
  
  @doc """
  Creates a backlog_item.
  
  ## Examples
  
  iex> create_backlog_item(%{field: value})
  {:ok, %BacklogItem{}}
  
  iex> create_backlog_item(%{field: bad_value})
  {:error, %Ecto.Changeset{}}
  
  """
  def create_backlog_item(attrs \\ %{}) do
    %BacklogItem{}
    |> BacklogItem.changeset(attrs)
    |> Repo.insert()
  end
  
  @doc """
  Updates a backlog_item.
  
  ## Examples
  
  iex> update_backlog_item(backlog_item, %{field: new_value})
  {:ok, %BacklogItem{}}
  
  iex> update_backlog_item(backlog_item, %{field: bad_value})
  {:error, %Ecto.Changeset{}}
  
  """
  def update_backlog_item(%BacklogItem{} = backlog_item, attrs) do
    backlog_item
    |> BacklogItem.changeset(attrs)
    |> Repo.update()
  end
  
  @doc """
  Deletes a backlog_item.
  
  ## Examples
  
  iex> delete_backlog_item(backlog_item)
  {:ok, %BacklogItem{}}
  
  iex> delete_backlog_item(backlog_item)
  {:error, %Ecto.Changeset{}}
  
  """
  def delete_backlog_item(%BacklogItem{} = backlog_item) do
    Repo.delete(backlog_item)
  end
  
  @doc """
  Returns an `%Ecto.Changeset{}` for tracking backlog_item changes.
  
  ## Examples
  
  iex> change_backlog_item(backlog_item)
  %Ecto.Changeset{data: %BacklogItem{}}
  
  """
  def change_backlog_item(%BacklogItem{} = backlog_item, attrs \\ %{}) do
    BacklogItem.changeset(backlog_item, attrs)
  end
end
