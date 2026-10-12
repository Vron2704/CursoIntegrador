<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.usuario}">
    <c:redirect url="index.jsp"/>
</c:if>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Gestión de Artículos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-secondary fw-bold">Registro de Artículos</h2>
        <div>
            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalNuevo">Nuevo Artículo</button>
            <a href="admin_panel.jsp" class="btn btn-dark">Regresar</a>
        </div>
    </div>

    <table class="table table-hover table-bordered shadow-sm">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Imagen</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Precio</th>
            <th>Stock</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="art" items="${articulos}">
            <tr>
                <td class="align-middle">${art.idArticulo}</td>
                <td class="align-middle text-center">
                    <img src="${art.imagen}" alt="Articulo" width="50" height="50" class="rounded-circle border" style="object-fit: cover;">
                </td>
                <td class="align-middle">${art.nombre}</td>
                <td class="align-middle">${art.descripcion}</td>
                <td class="align-middle">S/ ${art.precio}</td>
                <td class="align-middle fw-bold ${art.stock < 10 ? 'text-danger' : 'text-success'}">${art.stock}</td>
                <td class="align-middle text-center">
                    <a href="ArticuloController?accion=eliminar&id=${art.idArticulo}" class="btn btn-danger btn-sm" onclick="return confirm('¿Seguro de eliminar?');">Eliminar</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Modal Nuevo Artículo -->
<div class="modal fade" id="modalNuevo" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title">Añadir Nuevo Artículo</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <!-- enctype multipart/form-data necesario para imagenes -->
                <form action="ArticuloController" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="accion" value="guardar">
                    <label>Nombre del Artículo</label>
                    <input type="text" name="nombre" class="form-control mb-2" required>

                    <label>Descripción</label>
                    <textarea name="descripcion" class="form-control mb-2" rows="3"></textarea>

                    <div class="row">
                        <div class="col-6">
                            <label>Precio (S/)</label>
                            <input type="number" step="0.01" name="precio" class="form-control mb-2" required>
                        </div>
                        <div class="col-6">
                            <label>Stock</label>
                            <input type="number" name="stock" class="form-control mb-2" required>
                        </div>
                    </div>

                    <label>Imagen del Producto</label>
                    <input type="file" name="imagen" class="form-control mb-3" accept="image/*" required>

                    <button type="submit" class="btn btn-success w-100">Guardar Artículo</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>