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

    @GET @Path("{sku}")
    public ItemDTO byId(@PathParam("sku") String sku) throws Exception { 
        ItemDTO d = dao.findBySku(sku);
        if (d == null) throw new NotFoundException();
        return d;
    }

    @POST
    public Response create(ItemDTO d) throws Exception {
        return Response.status(Response.Status.CREATED).entity(dao.create(d)).build();
    }

    @PUT @Path("{sku}")
    public Response update(@PathParam("sku") String sku, ItemDTO d) throws Exception {
        boolean ok = dao.update(sku, d);
        if (!ok) throw new NotFoundException();
        return Response.ok().build();
    }

    @DELETE @Path("{sku}")
    public Response delete(@PathParam("sku") String sku) throws Exception {
        boolean ok = dao.delete(sku);
        if (!ok) throw new NotFoundException();
        return Response.noContent().build();
    }
}