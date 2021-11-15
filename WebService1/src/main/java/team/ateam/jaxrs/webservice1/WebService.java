package team.ateam.jaxrs.webservice1;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

import com.sun.jersey.api.container.httpserver.HttpServerFactory;
import com.sun.net.httpserver.HttpServer;

public class WebService {
	public static final String propsFile = "//Users//yingningchen//Downloads//jdbc.properties";
	
    public static Connection getConnection() throws IOException, SQLException
    {
      // Load properties

      FileInputStream in = new FileInputStream(propsFile);
      Properties props = new Properties();
      props.load(in);

      // Define JDBC driver

      String drivers = props.getProperty("jdbc.drivers");
      if (drivers != null)
        System.setProperty("jdbc.drivers", drivers);
        // Setting standard system property jdbc.drivers
        // is an alternative to loading the driver manually
        // by calling Class.forName()

      // Obtain access parameters and use them to create connection

      String url = props.getProperty("jdbc.url");
      String user = props.getProperty("jdbc.user");
      String password = props.getProperty("jdbc.password");

      return DriverManager.getConnection(url, user, password);
    }
	
    
    public static ArrayList<String> findNames(String video_id, Connection database)
    		   throws SQLException
    		  {
    			ArrayList<String> selectResults = new ArrayList<>();
    		    Statement statement = database.createStatement();
    		    ResultSet results = statement.executeQuery(
    		     "SELECT * FROM channellist WHERE video_id = '" + video_id + "'");
    		    while (results.next()) {
    		      String channel_id = results.getString("channel_id");
    		      String channel_name = results.getString("channel_name");
    		      selectResults.add(video_id +'@'+ channel_id +'@' +channel_name);
    		    }
    		    statement.close();
    		    return selectResults;
    		  }
    
    
    @GET
    @Path("/videoid/{video_id}")
    @Produces(MediaType.APPLICATION_JSON)
    public JSONArray addJSON(@PathParam("video_id") double video_id) {
        Connection connection = null;
        List<String> result= new ArrayList();
        JSONArray returnJson = new JSONArray();
        String temp = "a6AHVbfyQVs";
        try {
            connection = getConnection();
            result=findNames(temp, connection);
            for(int i =0; i < result.size() ; i++){
                String[] t;
                String delimeter = "@"; 
                t = result.get(i).split(delimeter); 
                JSONObject singleJson = new JSONObject();
                for(int j =0; j < t.length ; j++){
                    singleJson.put("id", i);
                    singleJson.put("video_id", t[0]);
                    singleJson.put("channel_id", t[1]);
                    singleJson.put("channel_name", t[2]);
                 }
            	singleJson.put("Object", returnJson);
            }

        }
        catch (Exception error) {
          error.printStackTrace();
        }
        return returnJson;
    }

}
