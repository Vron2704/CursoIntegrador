package com.platerialastra.controlador;

import com.platerialastra.dao.UsuarioDAO;
import com.platerialastra.models.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.validarLogin(correo, password);

        // 1. Verificamos que el usuario devuelto no sea nulo (evita NullPointerException)
        if (usuario != null) {
            HttpSession session = request.getSession();

            // 2. Guardamos el objeto COMPLETO bajo el nombre "usuario".
            // Esto evita que el código <c:if test="${empty sessionScope.usuario}"> te expulse del JSP.
            session.setAttribute("usuario", usuario);

            // Puedes mantener las variables extra en sesión si las necesitas
            session.setAttribute("idEmpleado", usuario.getIdEmpleado());
            session.setAttribute("nombres", usuario.getNombres());
            session.setAttribute("cargo", usuario.getCargo());

            // 3. Redirigimos según el cargo
            String cargo = usuario.getCargo();
            if (cargo != null && (cargo.equalsIgnoreCase("Administrador") || cargo.equalsIgnoreCase("Admin"))) {
                response.sendRedirect("admin_panel.jsp");
            } else {
                response.sendRedirect("empleado_panel.jsp");
            }
        } else {
            // 4. Si el objeto es nulo, enviamos de regreso al index activando el mensaje de error
            response.sendRedirect("index.jsp?error=true");
        }
    }
}