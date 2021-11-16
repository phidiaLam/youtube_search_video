# Youtube search video

## Introduce

This project is using several video IDs to find the channels and the video infomation of these channels.

## How to use?

#### Configuration environment

1. install `tomcat` and `jdk-1.8`
2. add jar files in `youtube_search_video/jersey_jar.zip` into `Webservice1`, `Webservice2` and `youtubeClient` lib.
3. add jar files in `youtube_search_video/database_jar.zip` into `database1`, `database2`, `Webservice1` and `Webservice2` lib.

#### Create tables in mysql database.

1. using mysql command to create a database.
2. change the file `youtube_search_video/jdbc.properties`. Change `url`, `name` and `password` according to yourself.
3. if code cannot find path of `jdbc.properties` and `channelList.txt`, change the files path in the code.
   - database1
     - change `jdbc.properties` path in command line `23` to the path in your computer.
     - change `channelList.txt` path in command line `160` to the path in your computer.
   - database2
     - change `jdbc.properties` path in command line `17` to the path in your computer.
     - change `channelList.txt` path in command line `139` to the path in your computer.
4. run `CreateDB.java` in `database1` and `database2` to create table `channellist` and `videolist`.

#### Run the web services 1 and web service 2

1. if code cannot find path of `jdbc.properties`, change the path `jdbc.properties` in the code.
   - in the command line `9` of `webservice1`
   - in the command line `10` of `webservice2`
2. using java to run the `WebServiceStartUp.java` in path `WebService1\src\main\java\team\ateam\jaxrs\wevservice1` and `WebService2\src\main\java\team\ateam\jaxrs\wevservice2`. Then this two webserivce run in port `9999` and `9998`

#### Start the Client

1. Using IDE
   - run the code using tomcat.
   - input `127.0.0.1:8080/youtubeClinet/home.jsp` in web address bar start using client.
2. Using war package
   - put war package `youtubeClient.war` which in folder `youtube_search_video/` under tomcat.
   - run the tomcat.
   - input `127.0.0.1:8080/youtubeClinet/home.jsp` in web address bar start using client.

#### Using CLient.

1. in `127.0.0.1:8080/youtubeClinet/home.jsp`, the video id list you can input as follow:
   ```
    gNd5Zdc1voI
    GaLlQau3sDU 
    lZo4udUGhuo
    S73u2WpW5uQ
    sEhy-RXkNo0
    1WifEFI6eK8
    T4_ImSneNIE
    wP8Fg-372gM
    LmmfR_Qd3KI
    kyfb8lGAveY
    m-QVxS8TvDo
    a6AHVbfyQVs
   ```
    you can input like this `gNd5Zdc1voI@T4_ImSneNIE@kyfb8lGAveY` to input multiple video id.
2. then, `127.0.0.1:8080/youtubeClinet/channelChoose.jsp` will show the channel according to video ids which you gave. You can choose several channels and submit.
3. `127.0.0.1:8080/youtubeClinet/videoList.jsp` page will show the video cover image and title according to channel ids which you gave.
4. final, click `details` button to go to `127.0.0.1:8080/youtubeClinet/videoDetail.jsp` page. This page will show cover image, title, descript, pushlish time, view counts, like counts, dislike counts and commend counts to you.

## Video to show
[![Watch the video](https://i9.ytimg.com/vi/8TCfe8eMuQY/mqdefault.jpg?sqp=CMj9zYwG&rs=AOn4CLAfUPgWRbgCgLMMvUwJpiUAf7INGg)](https://youtu.be/8TCfe8eMuQY)