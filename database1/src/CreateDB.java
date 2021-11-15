
import java.io.*;
import java.sql.*;
import java.util.*;


/**
 * Example of how to create and populate a table using JDBC.
 *
 * <p>The program demonstrates</p>
 * <ul>
 *   <li>Use of properties to hold JDBC driver and database details</li>
 *   <li>Use of SQL commands DROP, CREATE and INSERT</li>
 *   <li>Use of prepared statements to insert data efficiently</li>
 * </ul>
 *
 * @author Yingning Chen
 */

public class CreateDB {


  public static final String propsFile = "D://jdbc.properties";


  /**
   * Establishes a connection to the database.
   *
   * The details of which driver to use, which database to access
   * and the username and password to use are provided via a
   * properties file, rather than being hard-coded.
   *
   * @return Connection object representing the connection
   * @throws IOException if properties file cannot be accessed
   * @throws SQLException if connection fails
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
   * Creates a table to hold the data.
   *
   * @param database connection to database
   * @throws SQLException if table creation fails
   */

  public static void createTable(Connection database) throws SQLException
  {
    // Create a Statement object with which we can execute SQL commands

    Statement statement = database.createStatement();

    // Drop existing table, if present

    try {
      statement.executeUpdate("DROP TABLE channellist");
    }
    catch (SQLException error) {
      // Catch and ignore SQLException, as this merely indicates
      // that the table didn't exist in the first place!
    }

    // Create a fresh table

    statement.executeUpdate("CREATE TABLE channellist ("
    					  + "id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,"
                          + "video_id VARCHAR(15) NOT NULL,"
                          + "channel_id VARCHAR(30) NOT NULL,"
                          + "channel_name VARCHAR(50) NOT NULL,"
                          + "profile_pic VARCHAR(150) NOT NULL)");

    statement.close();
  }


  /**
   * Adds data to the table.
   *
   * @param in source of data
   * @param database connection to database
   * @throws IOException if there is a problem reading from the file
   * @throws SQLException if insertion fails for any reason
   */

  public static void addData(BufferedReader in, Connection database)
   throws IOException, SQLException
  {
    // Prepare statement used to insert data

    PreparedStatement statement =
     database.prepareStatement("INSERT INTO channellist"
     						+ "(video_id,channel_id,channel_name,profile_pic)"
    						+ "VALUES"
     						+ "(?,?,?,?)");

    // Loop over input data, inserting it into table...
 
    while (true) {

      // Obtain user ID, surname and forename from input file

      String line = in.readLine();
      if (line == null)
        break;
      StringTokenizer parser = new StringTokenizer(line,",");
      String video_id = parser.nextToken();
      String channel_id = parser.nextToken();
      String channel_name = parser.nextToken();
      String profile_pic = parser.nextToken();
      // Insert data into table

      statement.setString(1, video_id);
      statement.setString(2, channel_id);
      statement.setString(3, channel_name);
      statement.setString(4, profile_pic);
      statement.executeUpdate();

    }

    statement.close();
    in.close();
  }


public static void main(String[] argv)
{
  if (argv.length != 0) {
    System.err.println("we do not need parameters.");
    System.exit(1);
  }

  Connection database = null;

  try {
    BufferedReader input = new BufferedReader(new FileReader("D://channelList.txt"));
    database = getConnection();
    createTable(database);
    addData(input, database);
  }
  catch (Exception error) {
    error.printStackTrace();
  }
  finally {

    // This will always execute, even if an exception has
    // been thrown elsewhere in the code - so this is
    // the ideal place to close the connection to the DB...

    if (database != null) {
      try {
        database.close();
      }
      catch (Exception error) {}
    }
  }
}
}