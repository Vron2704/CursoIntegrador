package com.platerialastra.controlador;

import com.platerialastra.dao.ArticuloDAO;
import com.platerialastra.models.Articulo;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet(name = "ArticuloController", urlPatterns = {"/ArticuloController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ArticuloController extends HttpServlet {

    private ArticuloDAO articuloDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        articuloDAO = new ArticuloDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                listarArticulos(request, response);
                break;
            case "eliminar":
                eliminarArticulo(request, response);
                break;
            default:
                listarArticulos(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if ("guardar".equalsIgnoreCase(accion)) {
            guardarArticulo(request, response);
        } else {
            listarArticulos(request, response);
        }
    }

    private void listarArticulos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArticuloDAO articuloDAO = new ArticuloDAO();
        List<Articulo> lista = articuloDAO.listar();

        // Esta línea es la que hace la magia: inyecta la lista en la petición para el JSP
        request.setAttribute("articulos", lista);

        // Redirigimos a la vista
        request.getRequestDispatcher("articulo.jsp").forward(request, response);
    }

    private void guardarArticulo(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        // Lógica de subida de imagen
        String imagenUrl = "img/default.png";
        try {
            Part filePart = request.getPart("imagen");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                filePart.write(uploadPath + File.separator + fileName);
                imagenUrl = "uploads/" + fileName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        Articulo articulo = new Articulo();
        articulo.setNombre(nombre);
        articulo.setDescripcion(descripcion);
        articulo.setPrecio(precio);
        articulo.setStock(stock);
        articulo.setImagen(imagenUrl);

        articuloDAO.agregar(articulo);
        response.sendRedirect("ArticuloController?accion=listar");
    }

    private void eliminarArticulo(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        articuloDAO.eliminar(id);
        response.sendRedirect("ArticuloController?accion=listar");
    }
}