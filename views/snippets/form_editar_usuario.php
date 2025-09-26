<?php
// This is a snippet and expects to be loaded via AJAX.
// We can't do a session check here directly, but the endpoint that loads it should be protected.
?>
<form id="form-editar-usuario-modal" autocomplete="off">
    <input type="hidden" name="id" value="">
    <div class="row g-3">
        <div class="col-12">
            <label for="username" class="form-label">Nombre de Usuario:</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>

        <div class="col-12">
            <label for="role" class="form-label">Rol de Usuario:</label>
            <select class="form-select" id="role" name="role" required>
                <option value="admin">Administrador</option>
                <option value="viewer">Visualizador</option>
                <option value="invitado">Invitado</option>
            </select>
        </div>
    </div>

    <div class="modal-footer mt-4 d-flex justify-content-center">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
    </div>
</form>