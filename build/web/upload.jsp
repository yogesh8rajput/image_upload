<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Images by Category</title>
    <style>
        body {
            background-color: black;
            background-repeat: no-repeat;
            background-size: cover;
            text-decoration: none;
            text-align: center;
            font-size: 25px;
            color: white; /* Change text color for better visibility */
            margin: 0;
            padding: 0;
        }
        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin: 20px;
        }
        .card {
            background-color: white;
            color: black;
            border-radius: 10px;
            padding: 20px;
            width: 250px; /* Fixed width for cards */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        .card img {
            height: 150px;
            width: auto;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        .card h3 {
            font-size: 18px;
            color: #333;
            margin: 10px 0;
        }
        .card p {
            font-size: 14px;
            color: #555;
        }
        .search-form {
            margin: 20px 0;
        }
        .search-form input[type="text"] {
            padding: 10px;
            font-size: 16px;
            width: 250px;
            border-radius: 5px;
        }
        .search-form button {
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        .search-form button:hover {
            background-color: #0056b3;
        }
        a {
            text-decoration: none;
            color: black;
        }
    </style>
</head>
<body>

    <!-- Search Form -->
    <div class="search-form">
        <form method="get" action="">
            <input type="text" name="cat" placeholder="Enter category to search" required>
            <button type="submit">Search</button>
        </form>
    </div>

    <!-- Display Search Results -->
    <div class="card-container">
        <%
            String pict = request.getParameter("cat");

            if (pict != null && !pict.isEmpty()) {
                try {
                    // Database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/imageupload", "root", "1234");

                    // Prepare and execute the SQL query
                    PreparedStatement pt = con.prepareStatement("SELECT * FROM image WHERE categary = ?");
                    pt.setString(1, pict);
                    ResultSet rs = pt.executeQuery();

                    // Check if there are any results
                    if (!rs.isBeforeFirst()) {
                        out.print("<p style='color:red;'>No images found for category: " + pict + "</p>");
                    }

                    // Loop through and display each result as a card
                    while (rs.next()) {
                        String imagePath = rs.getString("image");
                        String title = rs.getString("categary"); // assuming a 'title' column
//                        String description = rs.getString("description"); // assuming a 'description' column
        %>
            <div class="card">
                <img src="Upload_img/<%= imagePath %>" alt="Image not found">
                <h3><%= title %></h3>
<!--                <p> description %></p>-->
            </div>
        <%
                    }

                    // Close resources
                    rs.close();
                    pt.close();
                    con.close();

                } catch (Exception e) {
                    out.print("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                }
            } else {
                out.print("<p style='color:red;'>Please enter a category to search.</p>");
            }
        %>
    </div>

</body>
</html>
