defmodule Board.ProductsTest do
  use Board.DataCase

  alias Board.{Products, Products.Product}

  @valid_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  test "list_products/0 returns all products" do
    product = insert(:product)
    assert Products.list_products() == [product]
  end

  test "list_products/1 returns products by user" do
    user = insert(:user)

    insert_list(2, :product)
    {:ok, %Product{} = product} = Products.create_product(user, @valid_attrs)

    assert length(Products.list_products(user)) == 1
    assert product.title == "some title"
  end

  test "get_product!/1 returns the product with given id" do
    product = insert(:product)
    assert Products.get_product!(product.id) == product
  end

  test "create_product/1 with valid data creates a product" do
    assert {:ok, %Product{} = product} = Products.create_product(@valid_attrs)
    assert product.title == "some title"
  end

  test "create_product/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
  end

  test "create_product/2 with valid data and user creates a product with user assigned" do
    user = insert(:user)
    assert {:ok, %Product{} = product} = Products.create_product(user, @valid_attrs)
    assert length(product.users) == 1
    assert product.title == "some title"
  end

  test "update_product/2 with valid data updates the product" do
    product = insert(:product)
    assert {:ok, %Product{} = product} = Products.update_product(product, @update_attrs)
    assert product.title == "some updated title"
  end

  test "update_product/2 with invalid data returns error changeset" do
    product = insert(:product)
    assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
    assert product == Products.get_product!(product.id)
  end

  test "delete_product/1 deletes the product" do
    product = insert(:product)
    assert {:ok, %Product{}} = Products.delete_product(product)
    assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
  end

  test "change_product/1 returns a product changeset" do
    product = insert(:product)
    assert %Ecto.Changeset{} = Products.change_product(product)
  end
end
