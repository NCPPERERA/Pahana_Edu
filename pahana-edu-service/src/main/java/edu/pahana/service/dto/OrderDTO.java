package edu.pahana.service.dto;

import java.util.ArrayList;
import java.util.List;

public class OrderDTO {
    public int id;
    public int customerId;
    public double total;
    public List<OrderItemDTO> items = new ArrayList<>();
}
