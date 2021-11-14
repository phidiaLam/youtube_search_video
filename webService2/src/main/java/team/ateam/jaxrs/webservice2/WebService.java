package team.ateam.jaxrs.webservice2;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;



@Path("/two")
public class WebService {

	public static final String propsFile = "F:\\git\\github\\youtube_search_video\\jdbc.properties";
	
	// id_list is multiple id's connected together and connect with @
    @GET
    @Path("/channel/{id_list}")
    @Produces(MediaType.APPLICATION_JSON)
    public String addPlainText(@PathParam("id_list") String id_list) {
        // split id_list to single id array by @
    	String[] id = id_list.split("@");
    	// init the json text
        String jsonText = null;
        Connection connection = null;
        // add each channel info by json format
        try {
    		connection = getConnection();
    		jsonText = "{\n";
            jsonText += "\t\"item\": [\n";
            for (int i = 0; i < id.length; i++) {
            	jsonText += "\t\t{\n";
            	// add record channel id in each loop
            	jsonText += "\t\t\t\"channelId\": \"" + id[i] + "\",\n";
            	jsonText += channelToVideo(id[i], connection);
            	if (i != id.length - 1) {
            		jsonText += "\t\t},\n";
            	} else {
            		jsonText += "\t\t}\n";
            	}
            }
            jsonText += "\t]\n";
            jsonText += "}";
    	} catch (Exception error) {
	      error.printStackTrace();
	    } finally {
	    	if (connection != null) {
		        try {
		          connection.close();
		        } catch (Exception error) {
		        	
		        }
	        }
	    }
        return jsonText;
    }
    
    // connect mysql using jdbc
    public static Connection getConnection() throws IOException, SQLException {
        // Load properties
        FileInputStream in = new FileInputStream(propsFile);
        Properties props = new Properties();
        props.load(in);

        // Define JDBC driver
        String drivers = props.getProperty("jdbc.drivers");
        if (drivers != null)
          System.setProperty("jdbc.drivers", drivers);

        // Obtain access parameters and use them to create connection
        String url = props.getProperty("jdbc.url");
        String user = props.getProperty("jdbc.user");
        String password = props.getProperty("jdbc.password");

        return DriverManager.getConnection(url, user, password);
    }
    
    /**
     * 
     * Queries the database to find video info.
     * 
     * @param channel_id channel_id to search for in database
     * @param database connection to database
     * @return jsontext json text produced by database search
     */
    public static String channelToVideo(String channel_id, Connection database) throws SQLException {
      Statement statement = database.createStatement();
      
      // search in the database
      ResultSet results = statement.executeQuery("SELECT * FROM videolist WHERE channel_id = '" + channel_id + "'");
      String jsontext = null;
      
      // add the video info by json format 
      jsontext = "\t\t\t\t\"info\": [\n";
      Boolean firstline = true;
      while (results.next()) {
        String video_id = results.getString("video_id");
        String video_name = results.getString("video_name");
        if (!firstline) {
        	jsontext += ",\n";
        }
        firstline = false;
        jsontext += "\t\t\t\t\t{\n";
        jsontext += "\t\t\t\t\t\t\"videoId\": \"" + video_id + "\",";
        jsontext += "\t\t\t\t\t\t\"videoName\": \"" + video_name + "\",";
        jsontext += "\t\t\t\t\t\t\"CoverImg\": \"https://i.ytimg.com/vi/" + video_id + "/hqdefault.jpg\"";
        jsontext += "\t\t\t\t\t}";
      }
      jsontext += "\n";
      jsontext += "\t\t\t\t]\n";
      statement.close();
      return jsontext;
    }
}


