import React from 'react';
import FormularioLabelWrapper from './FormularioLabelWrapper';
import FormularioHtmlFor from './FormularioHtmlFor';

function App() {
  return (
    <div className="container">
      {/* Versão 1: Label envolvendo o input */}
      <FormularioLabelWrapper />

      <div className="divider"></div>

      {/* Versão 2: Usando htmlFor */}
      <FormularioHtmlFor />
    </div>
  );
}

export default App;