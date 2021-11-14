package database2;
import java.io.*;
import java.sql.*;
import java.util.*;


/**
 * create a table for web service 2 using JDBC.
 * 
 * @author Wentao Lin
 * @version 1.0 [2021-11-14]
 */

public class CreateDB {


  public static final String propsFile = "F:\\git\\github\\youtube_search_video\\jdbc.properties";

  /**
   * using the jdbc.properties file to connect mysql database
   *
   * @return Connection object representing the connection
   */
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


  /**
   * Creates a table call videolist to record the info.
   *
   * @param database connection to database
   */

  public static void createTable(Connection database) throws SQLException
  {
    // Create a Statement object with which we can execute SQL commands
    Statement statement = database.createStatement();

    // Drop existing table, if present
    try {
      statement.executeUpdate("DROP TABLE videolist");
    }
    catch (SQLException error) {
    	
    }

    // Create a videoList table
    // channel_id: channel id
    // video_id: video id
    // video_name: title of video
    statement.executeUpdate("CREATE TABLE videolist ("
    		              + "id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,"
    		              + "channel_id VARCHAR(35) NOT NULL,"
                          + "video_id VARCHAR(15) NOT NULL,"
                          + "video_name VARCHAR(150) NOT NULL"
                          + ")CHARSET=utf8");

    statement.close();
  }


  /**
   * Adds data to the table "videolist".
   *
   * @param in: source of data
   * @param databas:e connection to database
   */

  public static void addData(BufferedReader in, Connection database)
   throws IOException, SQLException
  {
    // Prepare statement used to insert data
    PreparedStatement statement =
     database.prepareStatement("INSERT INTO videolist "
     						+ "(channel_id, video_id, video_name)"
     						+ "VALUES"
     						+ "(?,?,?)");

    // Loop over input data, inserting it into table...
    while (true) {
      // Obtain channel_id, video_id and video_name from input file
      String line = in.readLine();
      if (line == null)
        break;
      StringTokenizer parser = new StringTokenizer(line,",");
      String channel_id= parser.nextToken();
      String video_id = parser.nextToken();
      String video_name = parser.nextToken();

      // Insert data into table
      statement.setString(1, channel_id);
      statement.setString(2, video_id);
      statement.setString(3, video_name);
      statement.executeUpdate();
    }

    statement.close();
    in.close();
  }


  /**
   * main function
   */
  public static void main(String[] argv)
  {
    if (argv.length > 0) {
    	System.err.println("Do not need argument");
        System.exit(1);
    }

    // init connect
    Connection database = null;

    try {
      BufferedReader input = new BufferedReader(new FileReader("F:\\git\\github\\youtube_search_video\\database2\\src\\database2\\videoList.txt"));
      database = getConnection();
      createTable(database);
      addData(input, database);
    }
    catch (Exception error) {
      error.printStackTrace();
    }
    finally {

      // close the database connect
      if (database != null) {
        try {
          database.close();
        }
        catch (Exception error) {}
      }
    }
  }


}