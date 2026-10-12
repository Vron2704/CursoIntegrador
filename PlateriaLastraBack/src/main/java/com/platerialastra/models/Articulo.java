package com.platerialastra.modelo;

public class Articulo {
    private int idArticulo;
    private String nombre;
    private String descripcion;
    private double precio;
    private int stock;
    private String imagen;

    public Articulo() {}
    public int getIdArticulo() { return idArticulo; } public void setIdArticulo(int idArticulo) { this.idArticulo = idArticulo; }
    public String getNombre() { return nombre; } public void setNombre(String nombre) { this.nombre = nombre; }
    public String getDescripcion() { return descripcion; } public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public double getPrecio() { return precio; } public void setPrecio(double precio) { this.precio = precio; }
    public int getStock() { return stock; } public void setStock(int stock) { this.stock = stock; }
    public String getImagen() { return imagen; } public void setImagen(String imagen) { this.imagen = imagen; }
}