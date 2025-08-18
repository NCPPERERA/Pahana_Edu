package edu.pahana.service.dao;

import edu.pahana.service.dto.CustomerDTO;
import edu.pahana.service.util.DB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    public List<CustomerDTO> findAll() throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM customers ORDER BY id DESC");
             ResultSet rs = ps.executeQuery()) {
            List<CustomerDTO> out = new ArrayList<>();
            while (rs.next()) {
                CustomerDTO d = map(rs);
                out.add(d);
            }
            return out;
        }
    }
    public CustomerDTO findById(int id) throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM customers WHERE id=?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
                return null;
            }
        }
    }
    public CustomerDTO create(CustomerDTO d) throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement(
                "INSERT INTO customers(account_number,name,address,phone) VALUES (?,?,?,?)",
                Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, d.accountNumber);
            ps.setString(2, d.name);
            ps.setString(3, d.address);
            ps.setString(4, d.phone);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) d.id = rs.getInt(1);
            }
            return d;
        }
    }
    public boolean update(int id, CustomerDTO d) throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement(
                "UPDATE customers SET account_number=?, name=?, address=?, phone=? WHERE id=?")) {
            ps.setString(1, d.accountNumber);
            ps.setString(2, d.name);
            ps.setString(3, d.address);
            ps.setString(4, d.phone);
            ps.setInt(5, id);
            return ps.executeUpdate() == 1;
        }
    }
    public boolean delete(int id) throws Exception {
        try (Connection c = DB.get();
             PreparedStatement ps = c.prepareStatement("DELETE FROM customers WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        }
    }
    private CustomerDTO map(ResultSet rs) throws Exception {
        CustomerDTO d = new CustomerDTO();
        d.id = rs.getInt("id");
        d.accountNumber = rs.getString("account_number");
        d.name = rs.getString("name");
        d.address = rs.getString("address");
        d.phone = rs.getString("phone");
        return d;
    }

    public CustomerDTO findByAccountNumber(String accountNumber) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
