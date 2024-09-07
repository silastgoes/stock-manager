-- name: ListCategories :many
SELECT * FROM categories;

-- name: GetCategory :one 
SELECT * FROM categories
WHERE id = ?;

-- name: CreateCategory :exec
INSERT INTO categories (id, name, description, is_perishable, is_durable, hazard_level, is_batch_retrieved, is_individual)
VALUES (?, ?, ?, ?, ?, ?, ?, ?);

-- name: UpdateCategory :exec
UPDATE categories SET 
    name = ?,
    description = ?,
    is_perishable = ?,
    is_durable = ?,
    hazard_level = ?,
    is_batch_retrieved = ?,
    is_individual = ?
WHERE id = ?;

-- name: DeleteCategory :exec
DELETE FROM categories WHERE id = ?;

-- name: ListItems :many
SELECT i.*, c.name FROM items i 
JOIN categories c ON i.category_id = c.id;

-- name: ListItemsStock :many
SELECT i.*, c.name FROM items i 
JOIN categories c ON i.category_id = c.id
WHERE c.is_individual = TRUE;

-- name: CreateItem :exec
INSERT INTO items (id, name, description, external_id, category_id, is_in_stock)
VALUES (?, ?, ?, ?, ?, ?);

-- name: UpdateItem :exec
UPDATE items SET 
    id = ?,
    name = ?,
    description = ?,
    external_id = ?,
    category_id = ?,
    is_in_stock = ?
WHERE id = ?;

-- name: UpdateItemStatus :exec
UPDATE items SET 
    is_in_stock = ?
WHERE id = ?;

-- name: DeleteItem :exec
DELETE FROM items WHERE id = ?;

-- name: ListItemBatchesStock :many
SELECT i.*, SUM(b.in_transit_quantity), SUM(b.current_quantity), c.name FROM items i 
JOIN categories c ON i.category_id = c.id
RIGHT JOIN batches b ON b.item_id = i.id
WHERE c.is_individual = FALSE;

-- name: CreateBatche :exec
INSERT INTO batches (id, item_id, initial_quantity, current_quantity, in_transit_quantity )
VALUES (?, ?, ?, ?, ?);

-- name: UpdateBatche :exec
UPDATE batches SET 
    id = ?,
    item_id = ?,
    initial_quantity = ?,
    current_quantity = ?,
    in_transit_quantity = ?
WHERE id = ?;

-- name: UpdateBatcheQuantity :exec
UPDATE batches SET 
    current_quantity = ?,
    in_transit_quantity = ?
WHERE id = ?;

-- name: DeleteBatche :exec
DELETE FROM batches WHERE id = ?;
