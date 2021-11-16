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
<script>
//get the value of chosen checkbox
//to know which channels the users are interested in
function chk(){
    let obj=document.getElementsByName('cbx'); 
    let s='';
    if(obj[i].checked){
    if(obj.length>=0)
    	s=obj[0].value;}
    for(var i=1; i<obj.length; i++){ 
        if(obj[i].checked){
        	if(obj[i].value!=obj[i-1].value)
        		s+='@'+obj[i].value;
        	}
    } 
    //set value for the hidden input
    //send parameters with form
    let input = document.getElementById("hid");
    input.setAttribute("value", s);
    let a =input.getAttribute("value");
} 

</script>
<body>
<%-- title and reminder --%>
	<h1>Channel List</h1>
	<h2>Please choose your interested channels.</h2>
<%-- Json array got with webservice--%>
	<%
	String ids = "";
	String [] channelIds = {};
	String videos = request.getParameter("videos");
	String resultJsonText = jsonText(videos);
	JSONArray resultArray = getInfoOfChannels(resultJsonText);
	%>
	<form action="videoList.jsp" method="GET">
<div class="channel">
		<table border="1">
		<tr class="header">
			<td></td>
			<td>Video Ids</td>
			<td>Channel PIC</td>
			<td>Channel Name</td>
		</tr>
			<%--use for loop to show the info got by webservice in table --%>
				<%
				for (int i = 0; i < resultArray.length(); i++) {
					JSONObject jsono = resultArray.getJSONObject(i);
					String cid = jsono.get("channel_id").toString();
				%>
				<tr>			
					<td>
						<div>
							<input onclick="chk()" type="checkbox" name=cbx class="option" value=<%=cid %>>
						</div>
					</td>
					<%
					String vid = jsono.get("video_id").toString();
					%>
					<td>
						<div>
							<%=vid%>
						</div>
					</td>

					<td>
						<div class="profile">
							<img
								<%String url = jsono.get("profile_picture").toString();%>
								src=<%=url%> alt="profile">
						</div>
					</td>



					<%
					String name = jsono.get("channel_name").toString();
					%>
					<td>
						<div><%=name%></div>
					</td>

				</tr>
				<%
				}
				%>
			</div>

			
		</table>
		</div>
		<div id="submit">
			<input type="submit" value="Submit" class="sub">
		</div>
		<%--use hidden input to send parameters with chosen channel --%>
		<input type="hidden" name="idList" id="hid">
		
	</form>


	<%-- the service request url is http://localhost:9998/webservice1one/videoid/{video_id} --%>
	<%!static final String REST_URI = "http://localhost:9998/webservice1";
	static final String QUERY_PATH = "one/videoid";

	private String jsonText(String keyvideos) {
		ClientConfig config = new DefaultClientConfig();
		Client client = Client.create(config);
		WebResource service = client.resource(REST_URI);
		WebResource channelService = service.path(QUERY_PATH).path("/" + keyvideos);
		String jsontext = getOutputAsJson(channelService);
		return jsontext;
	}

	// get from web service, and get response json text
	private String getOutputAsJson(WebResource service) {
		return service.accept(MediaType.APPLICATION_JSON).get(String.class);
	}

	private JSONArray getInfoOfChannels(String json) {
		JSONArray resultArray = new JSONArray(json);
		return resultArray;
	}%>
</body>
<style type="text/css">
.header{
font-size:20px;
}
.channel {
	height: 15%;
    text-align: center;
    display: flex;
    justify-content: space-evenly;
}

.option {
	margin-top: 10;
}

.profile {
	margin-top: 5%;
}
h1,h2{
text-align:center;
}
#submit{
margin-top:2%;
text-align:center;
}
.sub{
margin-top:10px;
font-size:22px;
background-color:#ebebeb;
}
.sub:hover{
background-color:#adffe0;
}
.sub.active{
background-color:#4d83c9;
}
</style>
</html>