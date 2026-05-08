import React, { useState } from 'react';

function FormularioHtmlFor() {
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
    console.log('Dados enviados (htmlFor):', formData);
    alert(`Dados enviados:\nNome: ${formData.nome}\nEmail: ${formData.email}\nSenha: ${formData.senha}`);
  };

  return (
    <div className="card">
      <h2>✅ Versão 2: Usando htmlFor</h2>
      <form onSubmit={handleSubmit}>
        
        {/* Label separado do input - PRECISA de htmlFor */}
        <label htmlFor="nome-htmlfor">
          <span>Nome:</span>
        </label>
        <input
          id="nome-htmlfor"
          type="text"
          name="nome"
          placeholder="Digite seu nome"
          value={formData.nome}
          onChange={handleChange}
          required
        />

        {/* Label separado do input - PRECISA de htmlFor */}
        <label htmlFor="email-htmlfor">
          <span>Email:</span>
        </label>
        <input
          id="email-htmlfor"
          type="email"
          name="email"
          placeholder="Digite seu email"
          value={formData.email}
          onChange={handleChange}
          required
        />

        {/* Label separado do input - PRECISA de htmlFor */}
        <label htmlFor="senha-htmlfor">
          <span>Senha:</span>
        </label>
        <input
          id="senha-htmlfor"
          type="password"
          name="senha"
          placeholder="Digite sua senha"
          value={formData.senha}
          onChange={handleChange}
          required
        />

        <button type="submit">Enviar</button>
      </form>
    </div>
  );
}

export default FormularioHtmlFor;