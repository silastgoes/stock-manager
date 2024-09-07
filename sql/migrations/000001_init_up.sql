CREATE TABLE categories (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    is_perishable BOOLEAN NOT NULL,
    is_durable BOOLEAN NOT NULL,
    hazard_level INT NOT NULL,
    is_batch_retrieved BOOLEAN NOT NULL,
    is_individual BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE items (
    id VARCHAR(36) PRIMARY KEY,
    description TEXT,
    name VARCHAR(255) NOT NULL,
    external_id VARCHAR(255),
    category_id VARCHAR(36),
    is_in_stock BOOLEAN,
    expiration_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE batches (
    id VARCHAR(36) PRIMARY KEY,
    item_id VARCHAR(36),
    initial_quantity INT NOT NULL,
    current_quantity INT NOT NULL,
    in_transit_quantity INT NOT NULL,
    expiration_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES items(id)
);
