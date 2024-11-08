<%-- 
    Document   : category
    Created on : 08-Nov-2024, 11:21:08 pm
    Author     : yoges
--%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
   

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
        a {
            text-decoration: none;
            color: black;
        }
    </style>
</head>
<body>

    <div class="card-container">

        <%
            // Database connection and image fetch
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/imageupload", "root", "1234");
                Statement st1 = con.createStatement();
                ResultSet rs = st1.executeQuery("SELECT * FROM image");

                while (rs.next()) {
                    String imagePath = rs.getString("image");
                    String title = rs.getString("categary"); // assuming there's a 'title' column in your database
//                    String description = rs.getString("description"); // assuming a 'description' column exists
        %>
            <div class="card">
                <!-- Displaying the image -->
                <img src="Upload_img/<%= imagePath %>" alt="Image not found">
                <h3><%= title %></h3> <!-- Displaying the title of the image -->
               <!-- Displaying the description of the image -->
            </div>

        <%
                }
                rs.close();
                st1.close();
                con.close();
            } catch (Exception e) {
                out.print("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        %>

    </div>

</body>
</html>

