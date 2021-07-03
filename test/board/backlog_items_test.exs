defmodule Board.BacklogItemsTest do
  use Board.DataCase

  alias Board.{BacklogItems, BacklogItems.BacklogItem}

  @valid_attrs %{description: "some description", estimate: 42, title: "some title"}
  @update_attrs %{description: "some updated description", estimate: 43, title: "some updated title"}
  @invalid_attrs %{description: nil, estimate: nil, title: nil}

  test "list_backlog_items/0 returns all backlog_items" do
    backlog_item = insert(:backlog_item)
    assert BacklogItems.list_backlog_items() == [backlog_item]
  end

  test "list_backlog_items/1 returns all backlog_items by product" do
    product = insert(:product)
    insert(:backlog_item)

    backlog_item = insert(:backlog_item, product_id: product.id)

    assert BacklogItems.list_backlog_items(product.id) == [backlog_item]
  end

  test "get_backlog_item!/1 returns the backlog_item with given id" do
    backlog_item = insert(:backlog_item)
    assert BacklogItems.get_backlog_item!(backlog_item.id) == backlog_item
  end

  test "create_backlog_item/1 with valid data creates a backlog_item" do
    assert {:ok, %BacklogItem{} = backlog_item} = BacklogItems.create_backlog_item(@valid_attrs)
    assert backlog_item.description == "some description"
    assert backlog_item.estimate == 42
    assert backlog_item.title == "some title"
  end

  test "create_backlog_item/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = BacklogItems.create_backlog_item(@invalid_attrs)
  end

  test "update_backlog_item/2 with valid data updates the backlog_item" do
    backlog_item = insert(:backlog_item)
    assert {:ok, %BacklogItem{} = backlog_item} = BacklogItems.update_backlog_item(backlog_item, @update_attrs)
    assert backlog_item.description == "some updated description"
    assert backlog_item.estimate == 43
    assert backlog_item.title == "some updated title"
  end

  test "update_backlog_item/2 with invalid data returns error changeset" do
    backlog_item = insert(:backlog_item)
    assert {:error, %Ecto.Changeset{}} = BacklogItems.update_backlog_item(backlog_item, @invalid_attrs)
    assert backlog_item == BacklogItems.get_backlog_item!(backlog_item.id)
  end

  test "delete_backlog_item/1 deletes the backlog_item" do
    backlog_item = insert(:backlog_item)
    assert {:ok, %BacklogItem{}} = BacklogItems.delete_backlog_item(backlog_item)
    assert_raise Ecto.NoResultsError, fn -> BacklogItems.get_backlog_item!(backlog_item.id) end
  end

  test "change_backlog_item/1 returns a backlog_item changeset" do
    backlog_item = insert(:backlog_item)
    assert %Ecto.Changeset{} = BacklogItems.change_backlog_item(backlog_item)
  end
end
