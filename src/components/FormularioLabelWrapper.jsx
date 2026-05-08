import React, { useState } from 'react';

function FormularioLabelWrapper() {
  const [formData, setFormData] = useState({
    nome: '',
    email: '',
    senha: ''
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Dados enviados (Label Wrapper):', formData);
    alert(`Dados enviados:\nNome: ${formData.nome}\nEmail: ${formData.email}\nSenha: ${formData.senha}`);
  };

  return (
    <div className="card">
      <h2>✅ Versão 1: Label envolvendo o Input</h2>
      <form onSubmit={handleSubmit}>
        
        {/* Label envolvendo o input - NÃO precisa de htmlFor */}
        <label>
          <span>Nome:</span>
          <input
            type="text"
            name="nome"
            placeholder="Digite seu nome"
            value={formData.nome}
            onChange={handleChange}
            required
          />
        </label>

        {/* Label envolvendo o input - NÃO precisa de htmlFor */}
        <label>
          <span>Email:</span>
          <input
            type="email"
            name="email"
            placeholder="Digite seu email"
            value={formData.email}
            onChange={handleChange}
            required
          />
        </label>

        {/* Label envolvendo o input - NÃO precisa de htmlFor */}
        <label>
          <span>Senha:</span>
          <input
            type="password"
            name="senha"
            placeholder="Digite sua senha"
            value={formData.senha}
            onChange={handleChange}
            required
          />
        </label>

        <button type="submit">Enviar</button>
      </form>
    </div>
  );
}

export default FormularioLabelWrapper;