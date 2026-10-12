package com.platerialastra.dao;

import com.platerialastra.config.ConexionDB;
import com.platerialastra.models.Proveedor;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProveedorDAO {
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public List<Proveedor> listar() {
        List<Proveedor> lista = new ArrayList<>();
        String sql = "SELECT * FROM proveedores ORDER BY id_proveedor DESC";
        try {
            con = ConexionDB.conectar();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Proveedor p = new Proveedor();
                p.setIdProveedor(rs.getInt("id_proveedor"));
                p.setRazonSocial(rs.getString("razon_social"));
                p.setRuc(rs.getString("ruc"));
                p.setTelefono(rs.getString("telefono"));
                p.setDireccion(rs.getString("direccion"));
                p.setContactoNombre(rs.getString("contacto_nombre"));
                p.setEstado(rs.getString("estado"));
                lista.add(p);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }

    public boolean agregar(Proveedor p) {
        String sql = "INSERT INTO proveedores (razon_social, ruc, telefono, direccion, contacto_nombre, estado) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            con = ConexionDB.conectar();
            ps = con.prepareStatement(sql);
            ps.setString(1, p.getRazonSocial());
            ps.setString(2, p.getRuc());
            ps.setString(3, p.getTelefono());
            ps.setString(4, p.getDireccion());
            ps.setString(5, p.getContactoNombre());
            ps.setString(6, p.getEstado());
            ps.executeUpdate();
            return true;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public void eliminar(int id) {
        String sql = "DELETE FROM proveedores WHERE id_proveedor=?";
        try {
            con = ConexionDB.conectar();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}