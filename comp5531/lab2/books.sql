CREATE TABLE books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    published_year INT,
    genre VARCHAR(100),
    price DECIMAL(10,2)
);

INSERT INTO books (title, author, published_year, genre, price) VALUES 
('To Kill a Mockingbird', 'Harper Lee', 1960, 'Fiction', 12.99),
('1984', 'George Orwell', 1949, 'Dystopian', 10.50),
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Classic', 15.75),
('Moby-Dick', 'Herman Melville', 1851, 'Adventure', 9.99),
('Pride and Prejudice', 'Jane Austen', 1813, 'Romance', 8.50);