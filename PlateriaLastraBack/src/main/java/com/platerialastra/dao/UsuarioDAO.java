package com.platerialastra.dao;

import com.platerialastra.config.ConexionDB;
import com.platerialastra.models.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {

    public Usuario validarLogin(String correo, String password) {
        Usuario usuario = null;
        // Consulta adaptada a tu esquema: verifica el correo, el password y si la cuenta está activa
        String sql = "SELECT id_empleado, correo, usuario, nombres, cargo, activo " +
                "FROM public.usuarios WHERE correo = ? AND password = ? AND activo = true";

        try (Connection conn = ConexionDB.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, correo);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setIdEmpleado(rs.getInt("id_empleado"));
                    usuario.setCorreo(rs.getString("correo"));
                    usuario.setUsuario(rs.getString("usuario"));
                    usuario.setNombres(rs.getString("nombres"));
                    usuario.setCargo(rs.getString("cargo"));
                    usuario.setActivo(rs.getBoolean("activo"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }
}