package edu.pahana.service.api;

import edu.pahana.service.dao.OrderDAO;
import edu.pahana.service.dto.OrderDTO;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("orders")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class OrderResource {
    private final OrderDAO dao = new OrderDAO();

    @POST
    public OrderDTO create(OrderDTO order) throws Exception {
        return dao.createOrder(order);
    }
}
