<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>home</title>
</head>
<body>
<font size=+2>
<%
java.util.Date now = new java.util.Date();
%>
<% if (now.getHours() < 12) { %>
<p>Good morning,
<% } else { %>
<p>Good afternoon,
<% } %>
visitor!</p>
<p>It is now <%= now.toString() %></p>
</font>
</body>
</html>