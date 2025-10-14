import { mostrarMensaje } from './grilla.alertas.js';

document.addEventListener('DOMContentLoaded', () => {
  const tablaBody = document.querySelector('#tabla-usuarios tbody');
  const btnAgregarUsuario = document.getElementById('btn-agregar-usuario');
  const modalElement = document.getElementById('user-modal');
  const userModal = new bootstrap.Modal(modalElement);

  let allUsers = [];

  // --- LÓGICA DE DATOS ---
  async function fetchUsers() {
    try {
      const response = await fetch('../acciones/get_usuarios.php');
      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || `HTTP error! status: ${response.status}`);
      }
      const result = await response.json();
      if (!result.ok) throw new Error(result.error || 'Error desconocido al obtener datos.');
      allUsers = result.data;
      renderTable(allUsers);
    } catch (error) {
      tablaBody.innerHTML = `<tr><td colspan="4" class="text-center text-danger">❌ Error: ${error.message}</td></tr>`;
    }
  }

  // --- LÓGICA DE RENDERIZADO ---
  function renderTable(users) {
    tablaBody.innerHTML = '';
    if (users.length === 0) {
      tablaBody.innerHTML = '<tr><td colspan="4" class="text-center">No se encontraron usuarios.</td></tr>';
      return;
    }
    users.forEach(user => {
      const fila = document.createElement('tr');
      fila.dataset.id = user.id;
      fila.innerHTML = `
        <td>${user.id}</td>
        <td>${escapeHTML(user.username)}</td>
        <td><span class="badge bg-secondary">${escapeHTML(user.role)}</span></td>
        <td>
          <div class="btn-group" role="group">
            <button class="btn btn-sm btn-warning btn-edit btn-editar-asignacion btn-icon-only" data-id="${user.id}" title="Editar usuario"><img src="../iconos/editarusuario.png" alt="Editar" class="action-icon"></button>
            <button class="btn btn-sm btn-info btn-change-password btn-icon-only" data-id="${user.id}" title="Cambiar contraseña"><img src="../iconos/contraseña.png" alt="Cambiar Contraseña" class="action-icon"></button>
            <button class="btn btn-sm btn-danger btn-delete btn-eliminar-asignacion btn-icon-only" data-id="${user.id}" title="Eliminar usuario"><img src="../iconos/eliminarusuario.png" alt="Eliminar" class="action-icon"></button>
          </div>
        </td>
      `;
      tablaBody.appendChild(fila);
    });
  }

  // --- HELPERS ---
  function escapeHTML(str) {
    const p = document.createElement('p');
    p.appendChild(document.createTextNode(str));
    return p.innerHTML;
  }

  function openModal(title, content, onOpen) {
    modalElement.querySelector('.modal-title').textContent = title;
    modalElement.querySelector('.modal-body').innerHTML = content;
    userModal.show();
    if (onOpen) {
      modalElement.addEventListener('shown.bs.modal', onOpen, { once: true });
    }
  }

  function closeModal() { userModal.hide(); }

  // --- MANEJADORES DE SUBMIT ---
  async function handleAddUserSubmit(e) {
    e.preventDefault();
    const form = e.target;
    const submitBtn = form.querySelector('button[type="submit"]');
    submitBtn.disabled = true;
    const data = { username: form.elements.username.value, password: form.elements.password.value, role: form.elements.role.value };

    try {
      const response = await fetch('../acciones/crear_usuario.php', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) });
      const result = await response.json();
      if (result.ok) {
        mostrarMensaje('success', result.mensaje);
        closeModal();
        fetchUsers();
      } else {
        mostrarMensaje('error', result.error);
      }
    } catch (error) {
      mostrarMensaje('error', 'Ocurrió un error de conexión.');
    } finally {
      submitBtn.disabled = false;
    }
  }

  async function handleEditUserSubmit(e) {
    e.preventDefault();
    const form = e.target;
    const submitBtn = form.querySelector('button[type="submit"]');
    submitBtn.disabled = true;
    const data = { id: form.elements.id.value, username: form.elements.username.value, role: form.elements.role.value };

    try {
      const response = await fetch('../acciones/editar_usuario.php', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) });
      const result = await response.json();
      if (result.ok) {
        mostrarMensaje('success', result.mensaje);
        closeModal();
        fetchUsers();
      } else {
        mostrarMensaje('error', result.error);
      }
    } catch (error) {
      mostrarMensaje('error', 'Ocurrió un error de conexión.');
    } finally {
      submitBtn.disabled = false;
    }
  }

  async function handleChangePassSubmit(e) {
    e.preventDefault();
    const form = e.target;
    const submitBtn = form.querySelector('button[type="submit"]');
    submitBtn.disabled = true;
    const data = { id: form.elements.id.value, new_password: form.elements.new_password.value };

    if (!data.new_password) {
      mostrarMensaje('error', 'La nueva contraseña no puede estar vacía.');
      submitBtn.disabled = false;
      return;
    }

    try {
      const response = await fetch('../acciones/cambiar_contrasena.php', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(data) });
      const result = await response.json();
      if (result.ok) {
        mostrarMensaje('success', result.mensaje);
        closeModal();
      } else {
        mostrarMensaje('error', result.error);
      }
    } catch (error) {
      mostrarMensaje('error', 'Ocurrió un error de conexión.');
    } finally {
      submitBtn.disabled = false;
    }
  }

  // --- EVENT LISTENERS ---
  btnAgregarUsuario.addEventListener('click', async () => {
    try {
      const response = await fetch('snippets/form_usuario.php');
      if (!response.ok) throw new Error('No se pudo cargar el formulario.');
      const formHtml = await response.text();
      openModal('Agregar Nuevo Usuario', formHtml, () => {
        document.getElementById('form-crear-usuario-modal').addEventListener('submit', handleAddUserSubmit);
      });
    } catch (error) {
      mostrarMensaje('error', error.message);
    }
  });

  tablaBody.addEventListener('click', async (e) => {
    const editTarget = e.target.closest('.btn-edit');
    const passTarget = e.target.closest('.btn-change-password');
    const deleteTarget = e.target.closest('.btn-delete');

    if (editTarget) {
      const userId = editTarget.dataset.id;
      const user = allUsers.find(u => u.id == userId);
      if (!user) return mostrarMensaje('error', 'Usuario no encontrado.');

      try {
        const response = await fetch('snippets/form_editar_usuario.php');
        if (!response.ok) throw new Error('No se pudo cargar el formulario de edición.');
        const formHtml = await response.text();
        openModal(`Editar Usuario: ${user.username}`, formHtml, () => {
          const form = document.getElementById('form-editar-usuario-modal');
          form.elements.id.value = user.id;
          form.elements.username.value = user.username;
          form.elements.role.value = user.role;
          form.addEventListener('submit', handleEditUserSubmit);
        });
      } catch (error) {
        mostrarMensaje('error', error.message);
      }
    }

    if (passTarget) {
      const userId = passTarget.dataset.id;
      const user = allUsers.find(u => u.id == userId);
      if (!user) return mostrarMensaje('error', 'Usuario no encontrado.');

      try {
        const response = await fetch('snippets/form_cambiar_pass.php');
        if (!response.ok) throw new Error('No se pudo cargar el formulario.');
        const formHtml = await response.text();
        openModal(`Cambiar Contraseña para: ${user.username}`, formHtml, () => {
          const form = document.getElementById('form-changepass-modal');
          form.elements.id.value = user.id;
          form.addEventListener('submit', handleChangePassSubmit);
        });
      } catch (error) {
        mostrarMensaje('error', error.message);
      }
    }

    if (deleteTarget) {
      const userId = deleteTarget.dataset.id;
      const user = allUsers.find(u => u.id == userId);
      if (!user) return mostrarMensaje('error', 'Usuario no encontrado.');

      Swal.fire({
        title: `¿Estás seguro de eliminar a ${user.username}?`,
        text: "¡Esta acción no se puede revertir!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Sí, ¡eliminar!',
        cancelButtonText: 'Cancelar'
      }).then(async (result) => {
        if (result.isConfirmed) {
          try {
            const response = await fetch('../acciones/eliminar_usuario.php', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ id: userId }) });
            const res = await response.json();
            if (res.ok) {
              // Usamos Swal.fire aquí para un mensaje de éxito más prominente tras la confirmación
              Swal.fire('Eliminado', res.mensaje, 'success');
              fetchUsers();
            } else {
              mostrarMensaje('error', res.error);
            }
          } catch (error) {
            mostrarMensaje('error', 'Ocurrió un error de conexión.');
          }
        }
      });
    }
  });

  // --- INICIALIZACIÓN ---
  fetchUsers();
});