package com.platerialastra.controlador;

import com.platerialastra.dao.UsuarioDAO;
import com.platerialastra.models.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {
    UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion.equalsIgnoreCase("Ingresar")) {
            String correo = request.getParameter("correo");
            String pass = request.getParameter("password");
            Usuario user = dao.validar(correo, pass);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", user);
                if (user.getCargo().equalsIgnoreCase("Admin")) {
                    response.sendRedirect("admin_panel.jsp");
                } else {
                    response.sendRedirect("empleado_panel.jsp");
                }
            } else {
                request.setAttribute("error", "Credenciales incorrectas");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if ("salir".equalsIgnoreCase(accion)) {
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
        }
    }
}