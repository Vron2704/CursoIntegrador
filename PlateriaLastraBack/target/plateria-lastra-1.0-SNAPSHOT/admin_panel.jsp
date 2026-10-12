<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.usuario}">
    <c:redirect url="index.jsp"/>
</c:if>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Panel de Administración</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="#">Platería Lastra</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="#">Empleados</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Proveedores</a></li>
                <li class="nav-item"><a class="nav-link" href="ArticuloController?accion=listar">Artículos</a></li>
            </ul>
            <div class="d-flex align-items-center text-white">
                <span class="me-3"><i class="fa fa-user"></i> ${usuario.usuario} (${usuario.cargo})</span>
                <a href="LoginController?accion=salir" class="btn btn-danger btn-sm">Salir</a>
            </div>
        </div>
    </div>
</nav>
<div class="container mt-5 text-center">
    <h1 class="display-4 fw-bold">Bienvenido al Panel Administrativo</h1>
    <p class="lead">Selecciona una opción en el menú superior para gestionar el sistema.</p>
</div>
</body>
</html>