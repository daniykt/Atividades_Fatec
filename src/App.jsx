import { useState, useEffect } from "react";
import StatusBar from "./components/StatusBar";
import Footer from "./components/Footer";
import educacao from "./assets/educacao.jpg";

function App() {
  const [alunos, setAlunos] = useState([
    { nome: "Ana Silva", curso: "ADS" },
    { nome: "Carlos Lima", curso: "GTI" },
  ]);

  const [nome, setNome] = useState("");
  const [curso, setCurso] = useState("");

  useEffect(() => {
    console.log("Sistema carregado!");
    console.log("Total de alunos:", alunos.length);
  }, []);

  function adicionarAluno() {
    if (nome && curso) {
      setAlunos([...alunos, { nome, curso }]);
      setNome("");
      setCurso("");
    }
  }

  return (
    <div>
      <StatusBar mensagem="Sistema Acadêmico" />

      <main style={{ padding: "20px" }}>
      <img src={educacao} alt="Educação" width={100} />

        <h2>Lista de Alunos</h2>

        <ul className="scroll">
          {alunos.map((aluno, index) => (
            <li key={index}>
              {aluno.nome} — {aluno.curso}
            </li>
          ))}
        </ul>

        <h3>Adicionar Aluno</h3>
        <input
          placeholder="Nome"
          value={nome}
          onChange={(e) => setNome(e.target.value)}
        />
        <input
          placeholder="Curso"
          value={curso}
          onChange={(e) => setCurso(e.target.value)}
          style={{ marginLeft: "8px" }}
        />
        <button onClick={adicionarAluno} style={{ marginLeft: "8px" }}>
          Adicionar
        </button>
      </main>

      <Footer />
    </div>
  );
}

export default App;