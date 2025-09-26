<form id="form-changepass-modal" autocomplete="off">
    <input type="hidden" name="id" value="">
    <div class="row g-3">
        <div class="col-12">
            <label for="new_password" class="form-label">Nueva Contraseña:</label>
            <input type="password" class="form-control" id="new_password" name="new_password" required>
        </div>
    </div>

    <div class="modal-footer mt-4 d-flex justify-content-center">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="submit" class="btn btn-primary">Actualizar Contraseña</button>
    </div>
</form>