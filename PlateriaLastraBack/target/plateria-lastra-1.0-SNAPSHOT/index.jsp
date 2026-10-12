<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - Platería Lastra</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body class="bg-light d-flex align-items-center vh-100">
<div class="container d-flex justify-content-center">
    <div class="card shadow-lg p-4" style="width: 25rem; border-radius: 15px;">
        <div class="text-center mb-4">
            <h3 class="fw-bold text-dark">Platería Lastra</h3>
            <p class="text-muted">Inicia sesión en tu cuenta</p>
        </div>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger text-center"><%= request.getAttribute("error") %></div>
        <% } %>
        <form action="LoginController" method="POST">
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control form-control-lg" required>
            </div>
            <div class="mb-4">
                <label class="form-label">Contraseña</label>
                <input type="password" name="password" class="form-control form-control-lg" required>
            </div>
            <input type="submit" name="accion" value="Ingresar" class="btn btn-dark w-100 btn-lg">
        </form>
    </div>
</div>
</body>
</html>