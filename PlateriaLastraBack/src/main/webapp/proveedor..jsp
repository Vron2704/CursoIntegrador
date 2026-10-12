<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.usuario}">
    <c:redirect url="index.jsp"/>
</c:if>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Gestión de Proveedores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-secondary fw-bold">Registro de Proveedores</h2>
        <div>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalNuevoProv">Nuevo Proveedor</button>
            <a href="admin_panel.jsp" class="btn btn-dark">Regresar</a>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-hover table-bordered shadow-sm">
            <thead class="table-dark text-center">
            <tr>
                <th>ID</th>
                <th>Razón Social</th>
                <th>RUC</th>
                <th>Contacto</th>
                <th>Teléfono</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="prov" items="${proveedores}">
                <tr class="text-center">
                    <td class="align-middle">${prov.idProveedor}</td>
                    <td class="align-middle text-start">${prov.razonSocial}</td>
                    <td class="align-middle">${prov.ruc}</td>
                    <td class="align-middle">${prov.contactoNombre}</td>
                    <td class="align-middle">${prov.telefono}</td>
                    <td class="align-middle">
                                <span class="badge ${prov.estado == 'Activo' ? 'bg-success' : 'bg-secondary'}">
                                        ${prov.estado}
                                </span>
                    </td>
                    <td class="align-middle">
                        <a href="ProveedorController?accion=eliminar&id=${prov.idProveedor}" class="btn btn-danger btn-sm" onclick="return confirm('¿Seguro de eliminar este proveedor?');">Eliminar</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal Nuevo Proveedor -->
<div class="modal fade" id="modalNuevoProv" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title">Añadir Nuevo Proveedor</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="ProveedorController" method="POST">
                    <input type="hidden" name="accion" value="guardar">

                    <label class="form-label fw-bold mt-2">Razón Social</label>
                    <input type="text" name="razonSocial" class="form-control" required>

                    <div class="row">
                        <div class="col-6">
                            <label class="form-label fw-bold mt-2">RUC</label>
                            <input type="text" name="ruc" class="form-control" maxlength="11" required>
                        </div>
                        <div class="col-6">
                            <label class="form-label fw-bold mt-2">Teléfono</label>
                            <input type="text" name="telefono" class="form-control">
                        </div>
                    </div>

                    <label class="form-label fw-bold mt-2">Nombre del Contacto</label>
                    <input type="text" name="contactoNombre" class="form-control">

                    <label class="form-label fw-bold mt-2">Dirección</label>
                    <textarea name="direccion" class="form-control" rows="2"></textarea>

                    <label class="form-label fw-bold mt-2">Estado</label>
                    <select name="estado" class="form-select mb-4">
                        <option value="Activo">Activo</option>
                        <option value="Inactivo">Inactivo</option>
                    </select>

                    <button type="submit" class="btn btn-primary w-100">Guardar Proveedor</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>