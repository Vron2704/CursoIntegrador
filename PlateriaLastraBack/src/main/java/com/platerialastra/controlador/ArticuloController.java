package com.platerialastra.controlador;

import com.platerialastra.dao.ArticuloDAO;
import com.platerialastra.modelo.Articulo;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet(name = "ArticuloController", urlPatterns = {"/ArticuloController"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class ArticuloController extends HttpServlet {
    ArticuloDAO dao = new ArticuloDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "listar":
                List<Articulo> lista = dao.listar();
                request.setAttribute("articulos", lista);
                request.getRequestDispatcher("articulo.jsp").forward(request, response);
                break;
            case "eliminar":
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect("ArticuloController?accion=listar");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if ("guardar".equalsIgnoreCase(accion)) {
            Articulo a = new Articulo();
            a.setNombre(request.getParameter("nombre"));
            a.setDescripcion(request.getParameter("descripcion"));
            a.setPrecio(Double.parseDouble(request.getParameter("precio")));
            a.setStock(Integer.parseInt(request.getParameter("stock")));

            // Procesamiento de Imagen
            Part filePart = request.getPart("imagen");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            if (fileName != null && !fileName.isEmpty()) {
                filePart.write(uploadPath + File.separator + fileName);
                a.setImagen("uploads/" + fileName);
            } else {
                a.setImagen("img/default.png");
            }

            dao.agregar(a);
            response.sendRedirect("ArticuloController?accion=listar");
        }
    }
}