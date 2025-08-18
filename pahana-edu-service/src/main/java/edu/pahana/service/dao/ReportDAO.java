package edu.pahana.service.dao;

import edu.pahana.service.util.DB;
import java.sql.*;
import java.util.*;

public class ReportDAO {

    // Sales Today Report
    public List<Map<String, Object>> getSalesToday() throws Exception {
        String sql = "SELECT o.id AS invoiceNo, c.name AS customer, o.total, o.created_at AS date " +
                     "FROM orders o " +
                     "INNER JOIN customers c ON o.customer_id = c.id " +
                     "WHERE DATE(o.created_at) = CURRENT_DATE " +
                     "ORDER BY o.created_at DESC";
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return mapResultSet(rs);
        }
    }

    // Top Items Report
    public List<Map<String, Object>> getTopItems() throws Exception {
        String sql = "SELECT i.name, SUM(oi.quantity) AS quantity, SUM(oi.line_total) AS salesAmount " +
                     "FROM order_items oi " +
                     "INNER JOIN items i ON oi.item_id = i.id " +
                     "INNER JOIN orders o ON oi.order_id = o.id " +
                     "WHERE DATE(o.created_at) = CURRENT_DATE " +
                     "GROUP BY i.name " +
                     "ORDER BY quantity DESC, i.name ASC";
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return mapResultSet(rs);
        }
    }

    // Generic utility
    public static List<Map<String, Object>> mapResultSet(ResultSet rs) throws Exception {
        List<Map<String, Object>> out = new ArrayList<>();
        ResultSetMetaData meta = rs.getMetaData();
        int colCount = meta.getColumnCount();
        while (rs.next()) {
            Map<String, Object> row = new LinkedHashMap<>();
            for (int i = 1; i <= colCount; i++) {
                row.put(meta.getColumnLabel(i), rs.getObject(i));
            }
            out.add(row);
        }
        return out;
    }
}
