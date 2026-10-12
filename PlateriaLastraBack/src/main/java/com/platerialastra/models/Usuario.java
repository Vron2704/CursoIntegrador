package com.platerialastra.models;

public class Usuario {
    private int id_empleado;
    private String usuario;
    private String correo;
    private String password;
    private String cargo;

    // Constructores, Getters y Setters
    public Usuario() {}
    public int getId() { return id_empleado; } public void setId(int id) { this.id_empleado = id; }
    public String getUsuario() { return usuario; } public void setUsuario(String usuario) { this.usuario = usuario; }
    public String getEmail() { return correo; } public void setEmail(String email) { this.correo = email; }
    public String getPassword() { return password; } public void setPassword(String password) { this.password = password; }
    public String getCargo() { return cargo; } public void setRol(String rol) { this.cargo = rol; }
}