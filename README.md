# 📚 Lista de Alunos — React com Vite

Atividade acadêmica desenvolvida com **React + Vite**, aplicando os conceitos fundamentais da biblioteca.

---

## 👨‍💻 Autor

**Danilo** — 2025

---

## 📋 Sobre o Projeto

Aplicação web para gerenciamento de uma lista de alunos, desenvolvida como atividade avaliativa da FATEC. O projeto explora os principais conceitos do React de forma prática e objetiva.

---

## ✅ Requisitos Implementados

| Requisito | Descrição | Pontos |
|-----------|-----------|--------|
| **StatusBar** | Componente que exibe o título do sistema via `props` | 1,5 pts |
| **Footer** | Rodapé com nome do autor e ano | 1,0 pt |
| **Imagem** | Exibição de imagem relacionada à educação | 1,0 pt |
| **useState** | Estado para armazenar lista de alunos (nome e curso) | 2,0 pts |
| **map** | Listagem dinâmica dos alunos na tela | 1,5 pts |
| **useEffect** | Exibição de mensagens no console ao carregar a aplicação | 1,5 pts |
| **Interação** | Botão e inputs para adicionar novos alunos | 1,0 pt |
| **Organização** | Estrutura de componentes separados e código legível | 0,5 pt |

**Total: 10,0 pontos**

---

## 🗂️ Estrutura do Projeto

```
src/
├── components/
│   ├── StatusBar.jsx
│   └── Footer.jsx
├── assets/
├── App.jsx
├── App.css
├── index.css
└── main.jsx
```

---

## 🚀 Como Executar

**Pré-requisitos:** Node.js instalado

```bash
# Instalar dependências
npm install

# Rodar em modo desenvolvimento
npm run dev
```

Acesse em: `http://localhost:5173`

---

## 📜 Scroll na Lista de Alunos

Para evitar poluição visual, a lista de alunos possui **scroll automático**. Quando o conteúdo ultrapassa o limite de altura definido, uma barra de rolagem aparece automaticamente — mantendo a interface limpa e organizada.

```jsx
<ul className="scroll">
  {alunos.map((aluno, index) => (
    <li key={index}>
      {aluno.nome} — {aluno.curso}
    </li>
  ))}
</ul>
```

```css
.scroll {
  max-height: 100px;
  overflow-y: auto;
}
```

- `max-height` — define o limite antes do scroll aparecer
- `overflow-y: auto` — scroll aparece só quando necessário

---

## 🛠️ Tecnologias Utilizadas

- [React](https://react.dev/)
- [Vite](https://vitejs.dev/)
- JavaScript (ES6+)
