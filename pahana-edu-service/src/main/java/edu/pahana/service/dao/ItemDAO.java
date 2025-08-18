package edu.pahana.service.dao;

import edu.pahana.service.dto.ItemDTO;
import edu.pahana.service.util.DB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {
    public List<ItemDTO> findAll() throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM items ORDER BY name");
             ResultSet rs = ps.executeQuery()) {
            List<ItemDTO> out = new ArrayList<>();
            while (rs.next()) out.add(map(rs));
            return out;
        }
    }

    public ItemDTO findBySku(String sku) throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM items WHERE sku=?")) {
            ps.setString(1, sku);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
                return null;
            }
        }
    }

    public ItemDTO create(ItemDTO d) throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement(
                "INSERT INTO items(sku,name,unit_price) VALUES (?,?,?)")) {
            ps.setString(1, d.sku);
            ps.setString(2, d.name);
            ps.setDouble(3, d.unitPrice);
            ps.executeUpdate();
            return d;
        }
    }

    public boolean update(String sku, ItemDTO d) throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement(
                "UPDATE items SET name=?, unit_price=? WHERE sku=?")) {
            ps.setString(1, d.name);
            ps.setDouble(2, d.unitPrice);
            ps.setString(3, sku);
            return ps.executeUpdate() == 1;
        }
    }

    public boolean delete(String sku) throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement("DELETE FROM items WHERE sku=?")) {
            ps.setString(1, sku);
            return ps.executeUpdate() == 1;
        }
    }

    private ItemDTO map(ResultSet rs) throws Exception {
        ItemDTO d = new ItemDTO();
        d.sku = rs.getString("sku");
        d.name = rs.getString("name");
        d.unitPrice = rs.getDouble("unit_price");
        return d;
    }
}