defmodule Board.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias Board.Repo

  alias Board.Accounts.User
  alias Board.Products.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  def list_products(%User{id: user_id}) do
    # TODO: wonder whether this is better or preload with user
    query = from(p in Product,
                 join: u in assoc(p, :users),
                 where: u.id == ^user_id)

    Repo.all(query)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def create_product(%User{} = user, attrs) do
    %Product{}
    |> Product.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:users, [user])
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{source: %Product{}}

  """
  def change_product(%Product{} = product) do
    Product.changeset(product, %{})
  end

  alias Board.Products.BacklogItem

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
