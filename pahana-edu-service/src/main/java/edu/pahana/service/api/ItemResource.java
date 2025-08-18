package edu.pahana.service.api;

import edu.pahana.service.dao.ItemDAO;
import edu.pahana.service.dto.ItemDTO;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("items")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ItemResource {
    private final ItemDAO dao = new ItemDAO();

    @GET
    public List<ItemDTO> all() throws Exception { return dao.findAll(); }

    @GET @Path("{id}")
    public ItemDTO byId(@PathParam("id") int id) throws Exception { 
        ItemDTO d = dao.findById(id);
        if (d == null) throw new NotFoundException();
        return d;
    }

    @POST
    public Response create(ItemDTO d) throws Exception {
        return Response.status(Response.Status.CREATED).entity(dao.create(d)).build();
    }

    @PUT @Path("{id}")
    public Response update(@PathParam("id") int id, ItemDTO d) throws Exception {
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
