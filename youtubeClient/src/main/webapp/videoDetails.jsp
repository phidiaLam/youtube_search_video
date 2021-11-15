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
<title>videoList</title>
</head>
<body>
<script>

</script>
    <%-- get the param from url --%>
  	<%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		String idList = request.getParameter("idList");
	%>
	
	<%-- return json text in web services 2 --%>
	<% String jsontext = jsonText(idList); %>
	<%= getInfoOfVideo(jsontext) %>
	<div class="out-container">
		<div class="row">
			<div class="video-info">
				<img class="info-img" src="https://i.ytimg.com/vi/m-QVxS8TvDo/hqdefault.jpg">
				<div class="info-title">Stephen Colbert And Jeff Goldblum Try On Each Others Glasses</div>
			 	<a herf="">
			 		<button class="info-detail">details</button>
			 	</a>
			</div>
			<div class="video-info">
				<img class="info-img" src="">
				<div class="info-title"></div>
			 	<div class="info-channel"></div>
			 	<button class=“info-detail”>
			 		<a herf=""></a>
			 	</button>
			</div>
			<div class="video-info">
				<img class="info-img" src="">
				<div class="info-title"></div>
			 	<div class="info-channel"></div>
			 	<button class=“info-detail”>
			 		<a herf=""></a>
			 	</button>
			</div>
			<div class="video-info">
				<img class="info-img" src="">
				<div class="info-title"></div>
			 	<div class="info-channel"></div>
			 	<button class=“info-detail”>
			 		<a herf=""></a>
			 	</button>
			</div>
			<div class="video-info">
				<img class="info-img" src="">
				<div class="info-title"></div>
			 	<div class="info-channel"></div>
			 	<button class=“info-detail”>
			 		<a herf=""></a>
			 	</button>
			</div>
		</div>
		<div class="row">
			<div class="video-info">
				<img class="info-img" src="">
				<div class="info-title"></div>
			 	<div class="info-channel"></div>
			 	<button class=“info-detail”>
			 		<a herf=""></a>
			 	</button>
			</div>
			<div class="video-info">
				<img class="info-img" src="">
				<div class="info-title"></div>
			 	<div class="info-channel"></div>
			 	<button class=“info-detail”>
			 		<a herf=""></a>
			 	</button>
			</div>
			<div class="video-info">
				<img class="info-img" src="">
				<div class="info-title"></div>
			 	<div class="info-channel"></div>
			 	<button class=“info-detail”>
			 		<a herf=""></a>
			 	</button>
			</div>
	</div>
	
	<%-- get the json text from web service2 api --%>
  	<%!
	  	static final String REST_URI = "http://localhost:9999/webservice2";
  		static final String LIST_URI = "two/channel";
	    
  		private String jsonText(String idList) throws MalformedURLException {
  	        ClientConfig config = new DefaultClientConfig();
  	        Client client = Client.create(config);
  	        WebResource service = client.resource(REST_URI);
  	        WebResource videoListService = service.path(LIST_URI).path(idList);
  	        String jsontext = getOutputAsJson(videoListService);
  	        return jsontext;
      	}
  		
  		private String getOutputAsJson(WebResource service) {
  	        return service.accept(MediaType.APPLICATION_JSON).get(String.class);
  	    }
  		
	    private String getInfoOfVideo(String json) {
	    	JSONObject obj= new JSONObject(json);
	    	
	    	String[] a = new String[5];
	    	return "11";
	    }
    %>
</body>
<style type="text/css">
.out-container {
	width: 80%;
	margin-left:10%;
}

.row {
	margin-top: 30px;
	display: flex;
	justify-content: flex-start;
}

.video-info {
	margin-left:calc((25%-10px)/5);
	width: 15%;
	height: 240px;
	border: 1px solid #aeb2b6;
	border-radius: 10px;
}

.info-img {
	width: 100%;
	border-radius: 10px;
}

.info-title {
	margin-left: 5px;
	margin-right: 5px;
	font-size: 12px;
	height: 70px;
}

.info-detail {
	width: 50px;
	height: 20px;
	position: relative;
    bottom: 0px;
    right: -125px;
    border-radius: 3px;
    border: none;
    background-color: #b2b9be; 
}

.info-detail:hover {
	background-color: #dce1e5;
}

.info-detail:active {
	background-color: #ecf1f5;
}

</style>
</html>