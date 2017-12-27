<%-- 
    Document   : index
    Created on : Dec 26, 2017, 6:54:57 PM
    Author     : Tuhsar Pahuja
--%>
<%@page import ="java.sql.*" %>
<%Class.forName("com.mysql.jdbc.Driver"); %> <%-- methods that loads mysql driver to the project--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Selecting data from a DB</title>
    </head>
    <body>
        <h1>Selecting data from a DB</h1>
        <%-- If we define our own class in JSP page we need to start the JSP tag with !
        --%>
        <%!
            public class Actor{
                String URL = "jdbc:mysql://localhost:3306/sakila";
                String USERNAME = "root";
                String PASSWORD = "Tushar123%";
                
                Connection connection = null;
                PreparedStatement selectActors = null;
                ResultSet resultSet = null;

                Actor(){
                    
                    try{
                        
                        connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                        selectActors = connection.prepareCall("SELECT actor_id, first_name, last_name FROM actor");

                    } catch(SQLException e){
                        
                        e.printStackTrace();

                       }
                

                }

                public ResultSet getActors(){
                
                    try{
                        resultSet = selectActors.executeQuery();

                    } catch(SQLException e){

                        e.printStackTrace();
                      }
                       
                      return resultSet;

                }
            }
        %>
        
        <%
            Actor actor = new Actor();
            ResultSet actors = actor.getActors();
        
        %>
        <table border="1">
            
            <tbody>
                <tr>
                    <td>Actor ID</td>
                    <td>First Name</td>
                    <td>Last Name</td>
                </tr>
                <%while(actors.next()) {%>
                <tr>
                    <td><%= actors.getInt("actor_id")%></td>
                    <td><%= actors.getString("first_name")%></td>
                    <td><%= actors.getString("last_name")%></td>
                </tr>
                <% } %>
            </tbody>
        </table>

    </body>
</html>
