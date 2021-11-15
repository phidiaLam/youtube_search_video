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

@Path("/one")
public class WebService {
	public static final String propsFile = "D://jdbc.properties";
	
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
    		      String profile_pic = results.getString("profile_pic");
    		      selectResults.add(video_id +'@'+ channel_id +'@' +channel_name +'@'+profile_pic);
    		    }
    		    statement.close();
    		    return selectResults;
    		  }
    
    
    @GET
    @Path("/videoid/{video_id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String addJSON(@PathParam("video_id") String video_id) {
        Connection connection = null;
        List<String> result= new ArrayList();
        JSONArray returnJson = new JSONArray();
        String[] keyvids;
        String delimeter = "@"; 
        keyvids = video_id.split(delimeter); 
        try {
        	for(int a=0; a<keyvids.length;a++) {
            connection = getConnection();
            result=findNames(keyvids[a], connection);
            for(int i =0; i < result.size() ; i++){
                String[] t;
                t = result.get(i).split(delimeter); 
                JSONObject singleJson = new JSONObject();
                for(int j =0; j < t.length ; j++){
                    singleJson.put("video_id", t[0]);
                    singleJson.put("channel_id", t[1]);
                    singleJson.put("channel_name", t[2]);
                    singleJson.put("profile_picture", t[3]);
                }
                returnJson.put(singleJson);
            }
            
        	}
        }
        catch (Exception error) {
          error.printStackTrace();
        }
        return returnJson.toString();
    }

}
