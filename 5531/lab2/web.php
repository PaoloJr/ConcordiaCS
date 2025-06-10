<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Database connection details
$servername = ".encs.concordia.ca";
$username = "";
$password = "";  
$database = "";

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch books data
$sql = "SELECT * FROM books";
$result = $conn->query($sql);

// Display data in an HTML table
echo "<h2>Books List</h2>";
echo "<table border='1'>
      <tr>
          <th>ID</th>
          <th>Title</th>
          <th>Author</th>
          <th>Published Year</th>
          <th>Genre</th>
          <th>Price</th>
      </tr>";

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>{$row['id']}</td>
                <td>{$row['title']}</td>
                <td>{$row['author']}</td>
                <td>{$row['published_year']}</td>
                <td>{$row['genre']}</td>
                <td>{$row['price']}</td>
              </tr>";
    }
} else {
    echo "<tr><td colspan='6'>No books found</td></tr>";
}

echo "</table>";

// Close connection
$conn->close();
?>