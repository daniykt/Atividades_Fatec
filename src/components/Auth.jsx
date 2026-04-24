import { useState } from "react";
import { auth } from "../firebase";
import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  sendEmailVerification
} from "firebase/auth";

const actionCodeSettings = {
  url: "https://danilo-fatec-db-3-s.firebaseapp.com"
};

function Auth() {
  const [email, setEmail] = useState("");
  const [senha, setSenha] = useState("");
  const [erro, setErro] = useState("");
  const [mensagem, setMensagem] = useState("");

  async function cadastrar() {
    if (!email || !senha) return setErro("Preencha todos os campos.");
    try {
      const cred = await createUserWithEmailAndPassword(auth, email, senha);
      await sendEmailVerification(cred.user, actionCodeSettings);
      setErro("");
      setMensagem("Cadastro realizado! Verifique seu e-mail antes de acessar.");
    } catch (e) {
      setMensagem("");
      switch (e.code) {
        case "auth/email-already-in-use": setErro("E-mail já está em uso!"); break;
        case "auth/weak-password": setErro("Senha deve ter ao menos 6 caracteres!"); break;
        case "auth/invalid-email": setErro("E-mail inválido!"); break;
        default: setErro("Erro ao cadastrar: " + e.message);
      }
    }
  }

  async function login() {
    if (!email || !senha) return setErro("Preencha todos os campos.");
    try {
      await signInWithEmailAndPassword(auth, email, senha);
      setErro("");
      setMensagem("");
    } catch (e) {
      setMensagem("");
      switch (e.code) {
        case "auth/wrong-password":
        case "auth/invalid-credential": setErro("E-mail ou senha inválidos."); break;
        case "auth/invalid-email": setErro("E-mail inválido!"); break;
        default: setErro("Erro ao entrar: " + e.message);
      }
    }
  }

  return (
    <div style={{ marginTop: "20px" }}>
      <h2>Login / Cadastro</h2>
      <input
        placeholder="E-mail"
        value={email}
        onChange={e => setEmail(e.target.value)}
      /><br /><br />
      <input
        placeholder="Senha"
        type="password"
        value={senha}
        onChange={e => setSenha(e.target.value)}
      /><br /><br />
      <button onClick={cadastrar}>Cadastrar</button>
      <button onClick={login} style={{ marginLeft: "8px" }}>Entrar</button>
      {erro && <p style={{ color: "red", marginTop: "8px" }}>{erro}</p>}
      {mensagem && <p style={{ color: "green", marginTop: "8px" }}>{mensagem}</p>}
    </div>
  );
}

export default Auth;