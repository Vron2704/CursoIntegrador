package com.platerialastra.dao;

import com.platerialastra.config.ConexionDB;
import com.platerialastra.models.Articulo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ArticuloDAO {
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public List<Articulo> listar() {
        List<Articulo> lista = new ArrayList<>();
        // Añadir 'public.' previene problemas de lectura en el esquema de Supabase
        String sql = "SELECT * FROM public.articulos ORDER BY id_articulo DESC";

        ConexionDB conectar = new ConexionDB();
        try (Connection con = ConexionDB.conectar();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Articulo art = new Articulo();
                art.setIdArticulo(rs.getInt("id_articulo"));
                art.setNombre(rs.getString("nombre"));
                art.setDescripcion(rs.getString("descripcion"));
                art.setPrecio(rs.getDouble("precio"));
                art.setStock(rs.getInt("stock"));
                art.setImagen(rs.getString("img_url"));
                lista.add(art);
            }
        } catch (Exception e) {
            System.err.println("Error al listar artículos: " + e.getMessage());
            e.printStackTrace();
        }
        return lista;
    }

    public boolean agregar(Articulo a) {
        String sql = "INSERT INTO articulos (nombre, descripcion, precio, stock, img_url) VALUES (?, ?, ?, ?, ?)";
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