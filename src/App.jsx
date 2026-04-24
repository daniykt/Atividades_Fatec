import { useState, useEffect } from "react";
import { auth, db } from "./firebase";
import { onAuthStateChanged, signOut } from "firebase/auth";
import { collection, addDoc, onSnapshot } from "firebase/firestore";
import StatusBar from "./components/StatusBar";
import Footer from "./components/Footer";
import Auth from "./components/auth";
import imagemEducacao from './assets/educacao.jpg'; 
import './App.css';

function App() {
  const [usuario, setUsuario] = useState(null);
  const [alunos, setAlunos] = useState([]);
  const [nome, setNome] = useState("");
  const [curso, setCurso] = useState("");
  const [erro, setErro] = useState("");

  useEffect(() => {
    const unsub = onAuthStateChanged(auth, (user) => {
      setUsuario(user);
      console.log(user ? "Usuário logado: " + user.email : "Sem usuário logado");
    });
    return () => unsub();
  }, []);

  useEffect(() => {
    if (!usuario || !usuario.emailVerified) return;
    const unsub = onSnapshot(collection(db, "alunos"), (snapshot) => {
      setAlunos(snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() })));
    });
    return () => unsub();
  }, [usuario]);

  async function adicionarAluno() {
    if (!nome || !curso) return setErro("Preencha nome e curso.");
    await addDoc(collection(db, "alunos"), { nome, curso });
    setNome("");
    setCurso("");
    setErro("");
  }

  async function logout() {
    await signOut(auth);
  }

  function TelaVerificacao() {
    return (
      <div style={{ marginTop: "20px" }}>
        <h2>⚠️ E-mail não verificado</h2>
        <p>Verifique seu e-mail antes de continuar. Acesse sua caixa de entrada e clique no link enviado.</p>
        <p>Após verificar, clique em <strong>Recarregar</strong> abaixo.</p>
        <button className="btn-primary" onClick={() => window.location.reload()}>Recarregar</button>
        <button onClick={logout} style={{ marginLeft: "8px" }} className="btn-logout">Sair</button>
      </div>
    );
  }

  return (
    <div className="app-container">
      <StatusBar mensagem="Sistema Acadêmico" />

      <main className="main-content">
      <div className="image-wrapper">
    <img src={imagemEducacao} alt="Educação" />
  </div>

        {!usuario && <Auth />}

        {usuario && !usuario.emailVerified && <TelaVerificacao />}

        {usuario && usuario.emailVerified && (
          <>
            <div className="user-info">
              <p>Logado como: <strong>{usuario.email}</strong></p>
              <button className="btn-logout" onClick={logout}>Sair</button>
            </div>

            <h2>Adicionar Aluno</h2>
            <div className="form-row">
              <input
                placeholder="Nome"
                value={nome}
                onChange={e => setNome(e.target.value)}
              />
              <input
                placeholder="Curso"
                value={curso}
                onChange={e => setCurso(e.target.value)}
              />
              <button className="btn-primary" onClick={adicionarAluno}>Adicionar</button>
            </div>
            {erro && <p className="erro">{erro}</p>}

            <h2>Lista de Alunos</h2>
            <ul className="scroll">
              {alunos.map(aluno => (
                <li key={aluno.id}>{aluno.nome} — {aluno.curso}</li>
              ))}
            </ul>
          </>
        )}
      </main>

      <Footer />
    </div>
  );
}

export default App;