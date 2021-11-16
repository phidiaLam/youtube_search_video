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
<title>Video Detail</title>
</head>
<body>
	<%-- get the param from url --%>
  	<%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		String videoId = request.getParameter("videoId");
	%>
	
	<%-- return json text in youtube web services --%>
	<%  String json = jsonText(videoId); 
		String detail = getDetailOfVideo(json);
	%>
	
	<%-- split string to each video info --%>
	<h1>Video Detail</h1>
	<%  String[] videoinfo;
    	videoinfo = detail.split("@");
	%>
	<div class="out-container">
		<div class="flex">
			<div class="img-space">
				<img src=<%=videoinfo[0] %>>
			</div>
			<div class="detail-space">
				<div class="title"><span class="key">Title:</span> <span><%=videoinfo[1] %></span></div>
				<div class="description"><span class="key">Description:</span> <span><%=videoinfo[2] %></span></div>
				<div class="publish"><span class="key">Publish Time:</span> <span><%=videoinfo[3] %></span></div>
				<div class="info">
					<span class="key">view counts:</span>&nbsp;<span><%=videoinfo[4] %></span>&nbsp;&nbsp;<span class="key">like counts:</span>&nbsp;<span><%=videoinfo[5] %></span>&nbsp;&nbsp;<span class="key">dislike counts:</span>&nbsp;<span><%=videoinfo[6] %></span>&nbsp;&nbsp;<span class="key">comment counts:</span>&nbsp;<span><%=videoinfo[7] %></span>
				</div>
			</div>
		</div>
	</div>

	<%-- get the json text from web service api --%>
	<%!
		// base url of api
		static final String REST_URI = "https://youtube.googleapis.com/youtube/v3/videos";
	    
  		private String jsonText(String videoId) throws MalformedURLException {
  	        ClientConfig config = new DefaultClientConfig();
  	        Client client = Client.create(config);
  	        WebResource service = client.resource(REST_URI);
  	        // add the param
  	      	WebResource videoDetailService = service.queryParam("part","snippet,statistics").queryParam("id",videoId).queryParam("key","AIzaSyDMAmpH7Yh0fPfMvYcXPUwrGeb1HKo5W6g");
  	        String jsontext = getOutputAsJson(videoDetailService);
  	        return jsontext;
      	}
  		
  		// get from web service, and get response json text
  		private String getOutputAsJson(WebResource service) {
  	        return service.accept(MediaType.APPLICATION_JSON).get(String.class);
  	    }
  		
	    private String getDetailOfVideo(String json) {
	    	// parse json text to each json object and array
	    	JSONObject obj= new JSONObject(json);
	    	JSONArray item = obj.getJSONArray("items");
	    	String info = "";
	    	// using the for loop, to get infomation in each array
	    	for (int i = 0; i < item.length(); i++) {
	    		JSONObject itemArray = item.getJSONObject(i); 
	    		
	    		JSONObject snippet = itemArray.getJSONObject("snippet");
	    		JSONObject statistics = itemArray.getJSONObject("statistics");
	    		
	    		String title = snippet.getString("title");
	    		String description = snippet.getString("description");
	    		String publishedAt = snippet.getString("publishedAt");
	    		
	    		JSONObject thumbnails = snippet.getJSONObject("thumbnails");
	    		JSONObject high = thumbnails.getJSONObject("high");
	    		String imgUrl = high.getString("url");
	    		
	    		String viewCount = statistics.getString("viewCount");
	    		String likeCount = statistics.getString("likeCount");
	    		String dislikeCount = statistics.getString("dislikeCount");
	    		String commentCount = statistics.getString("commentCount");
	    		
	    		// joint each info to a string, add symbol "@" between each of them to connect
	    		info += imgUrl +"@" +title + "@" + description + "@" + publishedAt + "@" + viewCount + "@" + likeCount + "@" + dislikeCount + "@" + commentCount + "#";
	    	}
	    	
	    	info.substring(0, info.length()-1);
	    	
	    	return info;
	    }
    %>
</body>
<style type="text/css">
h1 {
	text-align: center;
}
.out-container {
	width: 80%;
	margin-left:10%;
}
.flex {
	margin-top: 50px;
	display: flex;
	justify-content: flex-start;
}
.img-space {
 	width: 30%;
}
.img-space img {
	width: 100%;
}
.detail-space {
	width: 65%;
	margin-left: 5%;
}
.detail-space div {
 	margin-bottom: 20px;
}
.key {
    color: #63686c;
}
</style>
</html>