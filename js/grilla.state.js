// js/grilla.state.js

const state = {
  datosGlobales: null,
  yaRenderizado: false,
  modoExtendido: false,
  aulaSeleccionada: null,
  forceRender: false,
};

export const getState = () => state;

export const setState = (newState) => {
  Object.assign(state, newState);
};