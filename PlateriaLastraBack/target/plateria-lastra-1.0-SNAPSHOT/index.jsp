<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso al Sistema - Platería Lastra</title>
    <!-- Utilizando Bootstrap 5 para un diseño más profesional -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            border-radius: 10px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
            background: white;
            padding: 40px;
            width: 100%;
            max-width: 400px;
        }
    </style>
</head>
<body>

<div class="login-card">
    <h3 class="text-center text-secondary font-weight-bold mb-4">Platería Lastra</h3>

    <%
        // Capturar parámetro de error desde el Controlador
        String error = request.getParameter("error");
        if ("true".equals(error)) {
    %>
    <div class="alert alert-danger text-center" role="alert">
        Credenciales incorrectas o usuario inactivo.
    </div>
    <% } %>

    <!-- Formulario apuntando a LoginController -->
    <form action="LoginController" method="POST">
        <div class="mb-3">
            <label for="correo" class="form-label">Correo Electrónico</label>
            <input type="email" class="form-control" id="correo" name="correo" placeholder="ejemplo@correo.com" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Contraseña</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Tu contraseña" required>
        </div>
        <button type="submit" class="btn btn-dark w-100 mt-3">Iniciar Sesión</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>