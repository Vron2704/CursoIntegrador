<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.8">
    <title>Registro de Proveedores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<style type="text/css">
    body{
        background: ;
    }
    img{
        border-radius: 50px;
        --border-size: 2px;
        border: var(--border-size) solid black;
        border-image-width: var(--border-size);
    }
    .pag_btn {
        border-radius: 4px;
        margin: 4px;
        padding: 5px;
        cursor: pointer;
        border: none;
    }
    .pag_btn_des {
        border-radius: 4px;
        margin: 4px;
        padding: 5px;
        font-size: 14pt;
        cursor: pointer;
        border: none;
    }
    .pag_num {
        border-radius: 4px;
        margin: 4px;
        padding: 5px;
        cursor: pointer;
        border: none;
    }
</style>
<body>
<script>
    // Mostrar alerta si existe desde el servlet[cite: 3]
    <c:if test="${not empty sessionScope.alerta}">
    alert('${sessionScope.alerta}');
    <c:remove var="alerta" scope="session"/>
    </c:if>
    function eliminar() {
        let res=confirm("¿Esta seguro que desea eliminar?")
        return res;
    }
</script>
<div class="container">
    <h1 class="text-center text-secondary font-weight-bold p-4">Registro de Proveedores</h1>
    <div class="p-3 table-responsive">
        <button type="button" class="btn btn-success mb-2" data-bs-toggle="modal" data-bs-target="#exampleModal">Nuevo</button>
        <button type="button" class="btn btn-dark mb-2" onclick="history.back()">Regresar</button>
        <a href="ReporteServlet" class="btn btn-secondary mb-2">PDF</a> <!-- Cambiado a Servlet de Reporte -->
        <a href="../logout" class="btn btn-warning mb-2">Log Out</a> <!-- Cambiado a Servlet de Logout -->
        <nav class="navbar bg-body-tertiary" data-bs-theme="dark">
            <div class="container-fluid justify-content-center">
                <!-- Formulario de búsqueda procesado por el ProveedorServlet (doGet)[cite: 3] -->
                <form class="d-flex" role="search" method="GET" action="../proveedor">
                    <input name="buscador" placeholder="Buscar RUC o Razón Social" id="codigo" class="form-control me-2 light-table-filter" type="search" aria-label="Search" value="${param.buscador}" data-table="table_id">
                    <button class="btn btn-outline-light" type="submit">Buscar</button>
                </form>
            </div>
        </nav><br>
        <!-- Modal Nuevo Registro[cite: 3] -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Nuevo Registro</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="../proveedor" method="POST">
                            <input type="hidden" name="action" value="guardar">
                            <label>Razon Social</label>
                            <input type="text" class="form-control mb-2" placeholder="Razon Social" name="raz" required>
                            <label>RUC</label>
                            <input type="text" class="form-control mb-2" placeholder="N° RUC" name="ruc" maxlength="11" pattern="[0-9]{11}" inputmode="numeric" required>
                            <label>Telefono</label>
                            <input type="text" class="form-control mb-2" placeholder="Telefono" name="tel" required>
                            <label>Direccion</label>
                            <input type="text" class="form-control mb-2" placeholder="Direccion" name="dir" required>
                            <label>Nombre Contacto</label>
                            <input type="text" class="form-control mb-2" placeholder="Contacto" name="con" required>
                            <label>Estado</label>
                            <select class="form-select mb-3" name="est" required>
                                <option value="" disabled selected>Seleccione un estado</option>
                                <option value="Activo">Activo</option>
                                <option value="Inactivo">Inactivo</option>
                            </select>
                            <input type="submit" value="Guardar" class="form-control btn btn-success">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <table class="table table-hover table-striped table-bordered border-secondary table_id" id="tblDatos">
            <thead class="table-dark text-white">
            <tr>
                <th scope="col" class="text-center">Codigo</th>
                <th scope="col" class="text-center">Razon Social</th>
                <th scope="col" class="text-center">RUC</th>
                <th scope="col" class="text-center">Telefono</th>
                <th scope="col" class="text-center">Direccion</th>
                <th scope="col" class="text-center">Nombre Contacto</th>
                <th scope="col" class="text-center">Estado</th>
                <th scope="col" class="text-center" colspan="2">Acciones</th>
            </tr>
            </thead>
            <tbody>
            <!-- Uso de JSTL para iterar sobre la lista de proveedores[cite: 3] -->
            <c:forEach var="prov" items="${proveedores}">
                <tr>
                    <td class="text-center">${prov.idProveedor}</td>
                    <td class="text-center">${prov.razonSocial}</td>
                    <td class="text-center">${prov.ruc}</td>
                    <td class="text-center">${prov.telefono}</td>
                    <td class="text-center">${prov.direccion}</td>
                    <td class="text-center">${prov.contactoNombre}</td>
                    <td class="text-center">${prov.estado}</td>
                    <td>
                        <center>
                            <button data-bs-toggle="modal" data-bs-target="#modalEditar${prov.idProveedor}" class="btn btn-primary">Editar</button>
                            <a href="../proveedor?action=eliminar&id_proveedor=${prov.idProveedor}" class="btn btn-danger" onclick="return eliminar()">Eliminar</a>
                        </center>
                    </td>
                </tr>
                <!-- Modal Editar[cite: 3] -->
                <div class="modal fade" id="modalEditar${prov.idProveedor}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Editar Registro</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="../proveedor" method="POST">
                                    <input type="hidden" name="action" value="editar">
                                    <input type="hidden" name="id_proveedor" value="${prov.idProveedor}">
                                    <label>Razon Social</label>
                                    <input type="text" class="form-control mb-2" placeholder="Razon Social" name="raz" value="${prov.razonSocial}" required>
                                    <label>RUC</label>
                                    <input type="text" class="form-control mb-2" placeholder="N° RUC" name="ruc" value="${prov.ruc}" required>
                                    <label>Telefono</label>
                                    <input type="text" class="form-control mb-2" placeholder="Telefono" name="tel" value="${prov.telefono}" required>
                                    <label>Direccion</label>
                                    <input type="text" class="form-control mb-2" placeholder="Direccion" name="dir" value="${prov.direccion}" required>
                                    <label>Nombre Contacto</label>
                                    <input type="text" class="form-control mb-2" placeholder="Contacto" name="con" value="${prov.contactoNombre}" required>
                                    <label>Estado</label>
                                    <select class="form-select mb-3" name="est" required>
                                        <option value="" disabled <c:if test="${empty prov.estado}">selected</c:if>>Seleccione un estado</option>
                                        <option value="Activo" <c:if test="${prov.estado == 'Activo'}">selected</c:if>>Activo</option>
                                        <option value="Inactivo" <c:if test="${prov.estado == 'Inactivo'}">selected</c:if>>Inactivo</option>
                                    </select>
                                    <input type="submit" value="Editar" class="form-control btn btn-success">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            </tbody>
        </table>
        <div id="paginador" class="pagination justify-content-center"></div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script type="text/javascript" src="../js/page.js"></script>
<script type="text/javascript" src="../js/buscador.js"></script>
</body>
</html>aw