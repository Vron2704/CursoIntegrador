package com.platerialastra.controlador;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Destruye todas las variables de sesión[cite: 3]
        }
        String error = request.getParameter("error");
        response.sendRedirect("index.jsp" + (error != null ? "?error=" + error : ""));
    }
}