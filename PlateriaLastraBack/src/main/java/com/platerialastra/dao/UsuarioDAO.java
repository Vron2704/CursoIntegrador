package com.platerialastra.dao;

import com.platerialastra.config.ConexionDB;
import com.platerialastra.models.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAO {
    public Usuario validar(String email, String password) {
        Usuario user = null;
        String sql = "SELECT * FROM usuarios WHERE correo = ? AND password = ?";
        try (Connection con = ConexionDB.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new Usuario();
                user.setId(rs.getInt("id"));
                user.setUsuario(rs.getString("usuario"));
                user.setEmail(rs.getString("email"));
                user.setRol(rs.getString("cargo"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return user;
    }
    public boolean registrar(Usuario u) {
        String sql = "INSERT INTO usuarios (usuario, correo, password, cargo) VALUES (?, ?, ?, ?)";
        try (Connection con = ConexionDB.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, u.getUsuario());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getCargo());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}