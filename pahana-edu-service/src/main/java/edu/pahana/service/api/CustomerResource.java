package edu.pahana.service.api;

import edu.pahana.service.dao.CustomerDAO;
import edu.pahana.service.dto.CustomerDTO;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("customers")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class CustomerResource {
    private final CustomerDAO dao = new CustomerDAO();

    @GET
    public List<CustomerDTO> all() throws Exception { return dao.findAll(); }

    @GET @Path("{id}")
    public CustomerDTO byId(@PathParam("id") int id) throws Exception { 
        CustomerDTO d = dao.findById(id);
        if (d == null) throw new NotFoundException();
        return d;
    }

    @POST
    public Response create(CustomerDTO d) throws Exception {
        return Response.status(Response.Status.CREATED).entity(dao.create(d)).build();
    }

    @PUT @Path("{id}")
    public Response update(@PathParam("id") int id, CustomerDTO d) throws Exception {
        boolean ok = dao.update(id, d);
        if (!ok) throw new NotFoundException();
        return Response.ok().build();
    }

    @DELETE @Path("{id}")
    public Response delete(@PathParam("id") int id) throws Exception {
        boolean ok = dao.delete(id);
        if (!ok) throw new NotFoundException();
        return Response.noContent().build();
    }
}
