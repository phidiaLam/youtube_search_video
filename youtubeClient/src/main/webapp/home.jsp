<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>home</title>
</head>
<body>
<font size=+10>
<p>Please input the id of your interested videos. </p>
</font>
<font size=+2>
Video ids: <input type="text" name="videos" />
<br/>
Video ids: <input type="text" name="name">
<input type="submit" value="Submit" />
</form>
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