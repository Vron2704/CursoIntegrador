<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.usuario}">
    <c:redirect url="index.jsp"/>
</c:if>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nuevo Proveedor - Platería Lastra</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow-sm mx-auto" style="max-width: 600px; border-radius: 10px;">
        <div class="card-header bg-dark text-white">
            <h4 class="mb-0"><i class="fa fa-truck"></i> Registrar Nuevo Proveedor</h4>
        </div>
        <div class="card-body p-4">

            <!-- El formulario envía los datos al ProveedorController por el método POST -->
            <form action="ProveedorController" method="POST">

                <!-- Campo oculto clave: le dice al Controlador que ejecute el bloque de guardar -->
                <input type="hidden" name="accion" value="guardar">

                <div class="mb-3">
                    <label class="form-label fw-bold">Razón Social *</label>
                    <input type="text" name="razonSocial" class="form-control" placeholder="Ej. Platería Fina S.A.C." required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">RUC *</label>
                        <input type="text" name="ruc" class="form-control" maxlength="11" pattern="\d{11}" placeholder="11 dígitos" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Teléfono</label>
                        <input type="text" name="telefono" class="form-control" placeholder="Ej. 999888777">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Nombre del Contacto</label>
                    <input type="text" name="contactoNombre" class="form-control" placeholder="Ej. Juan Pérez">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Dirección</label>
                    <textarea name="direccion" class="form-control" rows="2" placeholder="Dirección completa"></textarea>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Estado</label>
                    <select name="estado" class="form-select">
                        <option value="Activo" selected>Activo</option>
                        <option value="Inactivo">Inactivo</option>
                    </select>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="ProveedorController?accion=listar" class="btn btn-secondary px-4">Cancelar</a>
                    <button type="submit" class="btn btn-primary px-4">Guardar Proveedor</button>
                </div>
            </form>

        </div>
    </div>
</div>
</body>
</html>