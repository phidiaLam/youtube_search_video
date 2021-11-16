<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.net.*"%>
<%@ page import="javax.ws.rs.core.MediaType"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>
<%@ page import="com.sun.jersey.api.client.WebResource"%>
<%@ page import="com.sun.jersey.api.client.config.ClientConfig"%>
<%@ page import="com.sun.jersey.api.client.config.DefaultClientConfig"%>
<%@ page import="org.json.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>home</title>
</head>
<body>
<div class="maincon">

<div class="reminder"><p>Please input the id of your interested video. </p></div>


<form action="channelChoose.jsp" method="GET">
<div class="search">
Video ids: <input type="text" name="videos" class="video"/>
<input type="submit" value="Submit" class="submit"/>
</div>
</form>
<div class="sugg">
<p>If you wanna search for more than one video id, please connect with @.</p>
<p>For example: GaLlQau3sDU@1WifEFI6eK8</p>
</div>
</div>
</body>
<style type="text/css">
.maincon{
	text-align: center;
	background-color: #fff;
	border-radius: 20px;
	width: 500px;
	height: 400px;
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translate(-50%,-50%);

}
.reminder{
text-align:center;
font-size:30px;

}
.search{
font-size:20px;
display:inline;
}
.video{
height:20px;
width:320px;
}
.sugg{
color:blue;
font-size:15px;
}
.submit{
height:20px;
background-color:#edf4ff;
}
.submit:hover {
	background-color: #fddeff;
}
.submit:active {
	background-color: #c1a5d6;
}
</style>
</html>