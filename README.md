```markdown
# 📋 Formulário React

Exercício de formulário em React com duas versões de label.

---

## 🚀 Como rodar

```bash
# 1. Instalar dependências
npm install

# 2. Iniciar o servidor de desenvolvimento
npm start
```

Acesse [http://localhost:3000](http://localhost:3000) no navegador.

---

## 📁 Estrutura de Pastas

```
meu-formulario/
├── public/
│   └── index.html
├── src/
│   ├── components/
│   │   ├── App.jsx
│   │   ├── FormularioLabelWrapper.jsx    ← Versão 1: label envolvendo input
│   │   └── FormularioHtmlFor.jsx         ← Versão 2: usando htmlFor
│   ├── index.js
│   └── index.css
├── package.json
└── README.md
```

---

## ✅ Requisitos do Exercício

| Requisito | Arquivo | Status |
|-----------|---------|--------|
| Campo **Nome** | Ambos | ✅ |
| Campo **Email** | Ambos | ✅ |
| Campo **Senha** | Ambos | ✅ |
| Usar **label envolvendo o input** | `FormularioLabelWrapper.jsx` | ✅ |
| Refazer usando **htmlFor** | `FormularioHtmlFor.jsx` | ✅ |

---

## 🔍 Diferença entre as versões

### Versão 1 — Label como wrapper (sem `htmlFor`)
```jsx
<label>
  <span>Nome:</span>
  <input type="text" name="nome" />
</label>
```
> O `<label>` envolve o `<input>`. Não precisa de `htmlFor` porque a associação é implícita.

---

### Versão 2 — Label separado (com `htmlFor`)
```jsx
<label htmlFor="nome-htmlfor">
  <span>Nome:</span>
</label>
<input id="nome-htmlfor" type="text" name="nome" />
```
> O `<label>` e o `<input>` são elementos irmãos. A associação é feita pelo atributo `htmlFor` (equivalente ao `for` do HTML).

---

## 📸 Saída Esperada

Ao rodar o projeto, você verá **dois formulários lado a lado**:

- **Esquerda:** Formulário com label envolvendo o input
- **Direita:** Formulário com label usando `htmlFor`

Ambos possuem os campos: **Nome**, **Email** e **Senha**.

---

## 🛠 Tecnologias

- React 18
- JSX
- CSS3
```