package com.platerialastra.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDB {
    // REEMPLAZA ESTOS DATOS CON LOS DE TU SUPABASE
    private static final String URL = "jdbc:postgresql://aws-1-us-east-1.pooler.supabase.com:6543/postgres?sslmode=require";
    private static final String USER = "postgres.xdblvjdkfnlrcmymujfz";
    private static final String PASS = "sistemasdistribuidos";

    public static Connection conectar() {
        Connection conexion = null;
        try {
            Class.forName("org.postgresql.Driver");
            conexion = DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error de conexión: " + e.getMessage());
        }
        return conexion;
    }
}