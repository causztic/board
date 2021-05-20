defmodule Board.ProductManagerTest do
  use Board.DataCase

  alias Board.ProductManager

  describe "products" do
    alias Board.ProductManager.Product

    @valid_attrs %{title: "some title", user_id: "some user_id"}
    @update_attrs %{title: "some updated title", user_id: "some updated user_id"}
    @invalid_attrs %{title: nil, user_id: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProductManager.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert ProductManager.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert ProductManager.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = ProductManager.create_product(@valid_attrs)
      assert product.title == "some title"
      assert product.user_id == "some user_id"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductManager.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = ProductManager.update_product(product, @update_attrs)
      assert product.title == "some updated title"
      assert product.user_id == "some updated user_id"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = ProductManager.update_product(product, @invalid_attrs)
      assert product == ProductManager.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = ProductManager.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> ProductManager.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = ProductManager.change_product(product)
    end
  end
end
