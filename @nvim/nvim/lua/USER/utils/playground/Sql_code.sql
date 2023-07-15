-- Create a table called `products`
CREATE TABLE products (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  price INT NOT NULL,
  PRIMARY KEY (id)
);

-- Insert some data into the `products` table
INSERT INTO products (name, price) VALUES
('iPhone 13 Pro Max', 1199),
('Samsung Galaxy S22 Ultra', 1099),
('Google Pixel 6 Pro', 899);

-- Select all the products from the `products` table
SELECT * FROM products;
