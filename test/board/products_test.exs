import Board.Factories

defmodule Board.ProductsTest do
  use Board.DataCase

  alias Board.{Products, Products.Product, Products.BacklogItem}

  describe "products" do
    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    test "list_products/0 returns all products" do
      product = insert!(:product)
      assert Products.list_products() == [product]
    end

    test "list_products/1 returns products by user" do
      user = insert!(:user)

      insert!(:product)
      insert!(:product)
      {:ok, %Product{} = product} = Products.create_product(user, @valid_attrs)

      assert length(Products.list_products(user)) == 1
      assert product.title == "some title"
    end

    test "get_product!/1 returns the product with given id" do
      product = insert!(:product)
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
      user = insert!(:user)
      assert {:ok, %Product{} = product} = Products.create_product(user, @valid_attrs)
      assert length(product.users) == 1
      assert product.title == "some title"
    end

    test "update_product/2 with valid data updates the product" do
      product = insert!(:product)
      assert {:ok, %Product{} = product} = Products.update_product(product, @update_attrs)
      assert product.title == "some updated title"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = insert!(:product)
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = insert!(:product)
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = insert!(:product)
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end

  describe "backlog_items" do
    @valid_attrs %{description: "some description", estimate: 42, title: "some title"}
    @update_attrs %{description: "some updated description", estimate: 43, title: "some updated title"}
    @invalid_attrs %{description: nil, estimate: nil, title: nil}

    test "list_backlog_items/0 returns all backlog_items" do
      backlog_item = insert!(:backlog_item)
      assert Products.list_backlog_items() == [backlog_item]
    end

    test "get_backlog_item!/1 returns the backlog_item with given id" do
      backlog_item = insert!(:backlog_item)
      assert Products.get_backlog_item!(backlog_item.id) == backlog_item
    end

    test "create_backlog_item/1 with valid data creates a backlog_item" do
      assert {:ok, %BacklogItem{} = backlog_item} = Products.create_backlog_item(@valid_attrs)
      assert backlog_item.description == "some description"
      assert backlog_item.estimate == 42
      assert backlog_item.title == "some title"
    end

    test "create_backlog_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_backlog_item(@invalid_attrs)
    end

    test "update_backlog_item/2 with valid data updates the backlog_item" do
      backlog_item = insert!(:backlog_item)
      assert {:ok, %BacklogItem{} = backlog_item} = Products.update_backlog_item(backlog_item, @update_attrs)
      assert backlog_item.description == "some updated description"
      assert backlog_item.estimate == 43
      assert backlog_item.title == "some updated title"
    end

    test "update_backlog_item/2 with invalid data returns error changeset" do
      backlog_item = insert!(:backlog_item)
      assert {:error, %Ecto.Changeset{}} = Products.update_backlog_item(backlog_item, @invalid_attrs)
      assert backlog_item == Products.get_backlog_item!(backlog_item.id)
    end

    test "delete_backlog_item/1 deletes the backlog_item" do
      backlog_item = insert!(:backlog_item)
      assert {:ok, %BacklogItem{}} = Products.delete_backlog_item(backlog_item)
      assert_raise Ecto.NoResultsError, fn -> Products.get_backlog_item!(backlog_item.id) end
    end

    test "change_backlog_item/1 returns a backlog_item changeset" do
      backlog_item = insert!(:backlog_item)
      assert %Ecto.Changeset{} = Products.change_backlog_item(backlog_item)
    end
  end
end
