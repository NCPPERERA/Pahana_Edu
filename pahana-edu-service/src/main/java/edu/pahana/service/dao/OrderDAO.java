package edu.pahana.service.dao;

import edu.pahana.service.dto.*;
import edu.pahana.service.util.DB;
import java.sql.*;
import java.util.List;

public class OrderDAO {

    public OrderDTO createOrder(OrderDTO order) throws Exception {
        try (Connection c = DB.get()) {
            c.setAutoCommit(false);
            try {
                try (PreparedStatement ps = c.prepareStatement(
                    "INSERT INTO orders(customer_id,total) VALUES (?,0)",
                    Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, order.customerId);
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) order.id = rs.getInt(1);
                    }
                }
                double total = 0;
                try (PreparedStatement psItem = c.prepareStatement("SELECT unit_price FROM items WHERE id=?");
                     PreparedStatement psLine = c.prepareStatement(
                        "INSERT INTO order_items(order_id,item_id,quantity,line_total) VALUES (?,?,?,?)")) {
                    for (OrderItemDTO it : order.items) {
                        psItem.setInt(1, it.itemId);
                        try (ResultSet rs = psItem.executeQuery()) {
                            if (!rs.next()) throw new SQLException("Item not found: " + it.itemId);
                            double price = rs.getDouble(1);
                            double line = price * it.quantity;
                            total += line;
                            psLine.setInt(1, order.id);
                            psLine.setInt(2, it.itemId);
                            psLine.setInt(3, it.quantity);
                            psLine.setDouble(4, line);
                            psLine.addBatch();
                        }
                    }
                    psLine.executeBatch();
                }
                try (PreparedStatement ps = c.prepareStatement("UPDATE orders SET total=? WHERE id=?")) {
                    ps.setDouble(1, total);
                    ps.setInt(2, order.id);
                    ps.executeUpdate();
                }
                c.commit();
                order.total = total;
                return order;
            } catch (Exception e) {
                c.rollback();
                throw e;
            } finally {
                c.setAutoCommit(true);
            }
        }
    }
}
