package com.platerialastra.controlador;

import com.platerialastra.dao.ProveedorDAO;
import com.platerialastra.models.Proveedor;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProveedorController", urlPatterns = {"/ProveedorController"})
public class ProveedorController extends HttpServlet {

    // Instanciamos el DAO que contiene las operaciones de Base de Datos
    ProveedorDAO dao = new ProveedorDAO();

    // El método doGet maneja las peticiones a través de la URL (Listar y Eliminar)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "listar":
                List<Proveedor> lista = dao.listar();
                request.setAttribute("proveedores", lista);
                request.getRequestDispatcher("proveedor.jsp").forward(request, response);
                break;

            case "eliminar":
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect("ProveedorController?accion=listar");
                break;
        }
    }

    // El método doPost maneja el envío seguro de formularios (El Registro / Guardar)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Configuramos UTF-8 para evitar problemas con las tildes o la letra "ñ"
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");

        if ("guardar".equalsIgnoreCase(accion)) {
            // 1. Instanciamos el modelo
            Proveedor p = new Proveedor();

            // 2. Capturamos los campos enviados por el formulario (modalNuevoProv)
            p.setRazonSocial(request.getParameter("razonSocial"));
            p.setRuc(request.getParameter("ruc"));
            p.setTelefono(request.getParameter("telefono"));
            p.setDireccion(request.getParameter("direccion"));
            p.setContactoNombre(request.getParameter("contactoNombre"));
            p.setEstado(request.getParameter("estado"));

            // 3. Enviamos el objeto lleno al DAO para insertarlo en Supabase
            dao.agregar(p);

            // 4. Redirigimos a la vista principal para ver la tabla actualizada
            response.sendRedirect("ProveedorController?accion=listar");
        }
    }
}