package com.platerialastra.dao;

import com.platerialastra.config.ConexionDB;
import com.platerialastra.modelo.Articulo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ArticuloDAO {
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public List<Articulo> listar() {
        List<Articulo> lista = new ArrayList<>();
        String sql = "SELECT * FROM articulos ORDER BY id_articulo DESC";
        try {
            con = ConexionDB.conectar();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Articulo a = new Articulo();
                a.setIdArticulo(rs.getInt("id_articulo"));
                a.setNombre(rs.getString("nombre"));
                a.setDescripcion(rs.getString("descripcion"));
                a.setPrecio(rs.getDouble("precio"));
                a.setStock(rs.getInt("stock"));
                a.setImagen(rs.getString("imagen"));
                lista.add(a);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return lista;
    }

    public boolean agregar(Articulo a) {
        String sql = "INSERT INTO articulos (nombre, descripcion, precio, stock, imagen) VALUES (?, ?, ?, ?, ?)";
        try {
            con = ConexionDB.conectar();
            ps = con.prepareStatement(sql);
            ps.setString(1, a.getNombre());
            ps.setString(2, a.getDescripcion());
            ps.setDouble(3, a.getPrecio());
            ps.setInt(4, a.getStock());
            ps.setString(5, a.getImagen());
            ps.executeUpdate();
            return true;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public void eliminar(int id) {
        String sql = "DELETE FROM articulos WHERE id_articulo=?";
        try {
            con = ConexionDB.conectar();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}