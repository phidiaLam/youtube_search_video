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
	<h1>Video Detail</h1>
	<div class="out-container">
		<div class="flex">
			<div class="img-space">
				<img src="https://i.ytimg.com/vi/Ks-_Mh1QhMc/hqdefault.jpg">
			</div>
			<div class="detail-space">
				<div class="title"><span class="key">Title:</span> <span>Your body language may shape who you are | Amy Cuddy</span></div>
				<div class="description"><span class="key">Description:</span> <span>Body language affects how others see us, but it may also change how we see ourselves. Social psychologist Amy Cuddy argues that "power posing" -- standing in a posture of confidence, even when we don't feel confident -- can boost feelings of confidence, and might have an impact on our chances for success. (Note: Some of the findings presented in this talk have been referenced in an ongoing debate among social scientists about robustness and reproducibility. Read Amy Cuddy's response here: http://ideas.ted.com/inside-the-debate-about-power-posing-a-q-a-with-amy-cuddy/)

Get TED Talks recommended just for you! Learn more at https://www.ted.com/signup.

The TED Talks channel features the best talks and performances from the TED Conference, where the world's leading thinkers and doers give the talk of their lives in 18 minutes (or less). Look for talks on Technology, Entertainment and Design -- plus science, business, global issues, the arts and more.

Follow TED on Twitter: http://www.twitter.com/TEDTalks
Like TED on Facebook: https://www.facebook.com/TED

Subscribe to our channel: https://www.youtube.com/TED</span></div>
				<div class="publish"><span class="key">Publish Time:</span> <span>2012-10-01T15:27:35Z</span></div>
				<div class="info">
					<span class="key">view counts:</span>&nbsp;<span>20446716</span>&nbsp;&nbsp;<span class="key">like counts:</span>&nbsp;<span>314199</span>&nbsp;&nbsp;<span class="key">dislike counts:</span>&nbsp;<span>5862</span>&nbsp;&nbsp;<span class="key">comment counts:</span>&nbsp;<span>8924</span>
				</div>
			</div>
		</div>
	</div>

	<%-- get the json text from web service api --%>
	<%!
		static final String REST_URI = "https://youtube.googleapis.com/youtube/v3/videos";
	    
  		private String jsonText(String videoId) throws MalformedURLException {
  	        ClientConfig config = new DefaultClientConfig();
  	        Client client = Client.create(config);
  	        WebResource service = client.resource(REST_URI);
  	      	WebResource videoDetailService = service.queryParam("part","snippet,statistics").queryParam("id",videoId).queryParam("key","AIzaSyDMAmpH7Yh0fPfMvYcXPUwrGeb1HKo5W6g");
  	        String jsontext = getOutputAsJson(videoDetailService);
  	        return jsontext;
      	}
  		
  		private String getOutputAsJson(WebResource service) {
  	        return service.accept(MediaType.APPLICATION_JSON).get(String.class);
  	    }
  		
	    private String getDetailOfVideo(String json) {
	    	JSONObject obj= new JSONObject(json);
	    	JSONArray item = obj.getJSONArray("items");
	    	String info = "";
	    	for (int i = 0; i < item.length(); i++) {
	    		JSONObject itemArray = item.getJSONObject(i); 
	    		
	    		JSONObject snippet = itemArray.getJSONObject("snippet");
	    		JSONObject statistics = itemArray.getJSONObject("statistics");
	    		
	    		String title = snippet.getString("title");
	    		String description = snippet.getString("description");
	    		String publishedAt = snippet.getString("publishedAt");
	    		
	    		JSONObject thumbnails = snippet.getJSONObject("thumbnails");
	    		JSONObject maxres = thumbnails.getJSONObject("maxres");
	    		String imgUrl = maxres.getString("url");
	    		
	    		String viewCount = statistics.getString("viewCount");
	    		String likeCount = statistics.getString("likeCount");
	    		String dislikeCount = statistics.getString("dislikeCount");
	    		String commentCount = statistics.getString("commentCount");
	    		
	    		info += title + "@" + description + "@" + publishedAt + "@" + imgUrl + "@" + viewCount + "@" + likeCount + "@" + dislikeCount + "@" + commentCount;
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