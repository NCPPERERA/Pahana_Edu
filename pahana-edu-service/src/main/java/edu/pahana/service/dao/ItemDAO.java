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
    public ItemDTO findById(int id) throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM items WHERE id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
                return null;
            }
        }
    }
    public ItemDTO create(ItemDTO d) throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement(
                "INSERT INTO items(sku,name,unit_price) VALUES (?,?,?)",
                Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, d.sku);
            ps.setString(2, d.name);
            ps.setDouble(3, d.unitPrice);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) d.id = rs.getInt(1);
            }
            return d;
        }
    }
    public boolean update(int id, ItemDTO d) throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement(
                "UPDATE items SET sku=?, name=?, unit_price=? WHERE id=?")) {
            ps.setString(1, d.sku);
            ps.setString(2, d.name);
            ps.setDouble(3, d.unitPrice);
            ps.setInt(4, id);
            return ps.executeUpdate() == 1;
        }
    }
    public boolean delete(int id) throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement("DELETE FROM items WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        }
    }
    private ItemDTO map(ResultSet rs) throws Exception {
        ItemDTO d = new ItemDTO();
        d.id = rs.getInt("id");
        d.sku = rs.getString("sku");
        d.name = rs.getString("name");
        d.unitPrice = rs.getDouble("unit_price");
        return d;
    }
}
