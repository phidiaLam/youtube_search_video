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
	<%  String infoString = getInfoOfVideo(jsontext); 
	    String[] infos = infoString.split("#");
	%>
	<div class="title">Video List</div>
	<div class="out-container">
	<% for(int i = 0; i < infos.length; i++) {
		String[] info = infos[i].split("@");%>
		<%if ((i % 5) == 0 && i != 0) { %>
			</div>
		<% } %>
		<%if ((i % 5) == 0) { %>
			<div class="row">
		<% } %>
				<div class="video-info">
					<img class="info-img" src="<%= info[2] %>">
					<div class="info-title"><%= info[0] %></div>
					<div class="info-id" hidden><%= info[1] %></div>
				 	<a href="/youtubeClient/videoDetail.jsp?videoId=<%= info[1] %>">
				 		<button class="info-detail">details</button>
				 	</a>
				</div>
		<%if (i == infos.length - 1) { %>
			<div class="row">
		<% } %>
	<% } %>	
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
	    	JSONArray item = obj.getJSONArray("item");
	    	String info = "";
	    	for (int i = 0; i < item.length(); i++) {
	    		JSONObject itemArray = item.getJSONObject(i); 
	    		JSONArray infoArray = itemArray.getJSONArray("info");
	    		for (int j = 0; j < infoArray.length(); j++) {
	    			JSONObject InfoObject = infoArray.getJSONObject(j);
	    			String videoName = InfoObject.getString("videoName"); 
	    			String videoId = InfoObject.getString("videoId"); 
	    			String CoverImg = InfoObject.getString("CoverImg"); 
	    			info += videoName + "@" + videoId + "@" + CoverImg + "#";
	    		}
	    	}
	    	
	    	info.substring(0, info.length()-1);
	    	
	    	return "11";
	    }
    %>
</body>
<style type="text/css">
.title {
	font-size: 60px;
	margin-top: 40px;
	text-align:center;
}
.out-container {
	width: 80%;
	margin-left:10%;
}

.row {
	margin-top: 50px;
	display: flex;
	justify-content: flex-start;
}

.video-info {
	margin-left:calc((25%-10px)/5);
	width: 15%;
	height: 16vw;
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
	margin-left: 67%;
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