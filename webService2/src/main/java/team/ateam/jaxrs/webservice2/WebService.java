package team.ateam.jaxrs.webservice2;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/two")
public class WebService {

    @GET
    @Path("/channel/{id}")
    @Produces(MediaType.TEXT_XML)
    public String addPlainText(@PathParam("a") double a, @PathParam("b") double b) {
        return (a + b) + "";
    }
}
