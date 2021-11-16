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
<title>ChooseChannel</title>
</head>
<body>
<%  %>

<%  
String videos=request.getParameter("videos");  
String resultJsonText = jsonText(videos);
JSONArray resultArray = getInfoOfChannels(resultJsonText);
%> 
<form>

<input type="checkbox" name="vehicle" value="Car">I have a car

<table border="1">
<% 

for( int i=0;i<resultArray.length();i++){
	JSONObject jsono = resultArray.getJSONObject(i);
	 %>
	 <input type="checkbox" name="vehicle" value=<%jsono.get("channel_id");%> >
	  <tr>
        <td><img src= <% jsono.get("profile_pic"); %> alt="profile"></td>
        <td> <% jsono.get("channel_name");%></td>
    </tr>
    <% 
}
 %>   
   
</table>
<input type="submit" value="Submit">
</form>


<%!
static final String REST_URI = "http://localhost:9998/webService1";
static final String QUERY_PATH = "one/videoid";

private String jsonText(String keyvideos)  {
	    ClientConfig config = new DefaultClientConfig();
	    Client client = Client.create(config);
	    WebResource service = client.resource(REST_URI);
	    WebResource channelService = service.path(QUERY_PATH).path("/"+keyvideos);
	    String jsontext = getOutputAsJson(channelService);
	    return jsontext;
  	}
		
	private String getOutputAsJson(WebResource service) {
	        return service.accept(MediaType.APPLICATION_JSON).get(String.class);
	    }
		
    private JSONArray getInfoOfChannels(String json) {
    	JSONObject obj= new JSONObject(json);
    	JSONArray resultArray = obj.getJSONArray("item");
    	return resultArray;
    }

    %>
</body>

</html>