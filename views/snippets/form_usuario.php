<form id="form-crear-usuario-modal" autocomplete="off">
    <div class="row g-3">
        <div class="col-12">
            <label for="username" class="form-label">Nombre de Usuario:</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>

        <div class="col-12">
            <label for="password" class="form-label">Contraseña:</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>

        <div class="col-12">
            <label for="role" class="form-label">Rol de Usuario:</label>
            <select class="form-select" id="role" name="role" required>
                <option value="">Seleccione un rol</option>
                <option value="admin">Administrador</option>
                <option value="viewer">Visualizador</option>
                <option value="invitado">Invitado</option>
            </select>
        </div>
    </div>

    <div class="modal-footer mt-4 d-flex justify-content-center">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="submit" class="btn btn-primary">Crear Usuario</button>
    </div>
</form>