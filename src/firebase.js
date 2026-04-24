import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import { getFirestore } from "firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyDo6rszaUwxHy_pCCh48CAIPejKf4msDAo",
  authDomain: "danilo-fatec-db-3-s.firebaseapp.com",
  projectId: "danilo-fatec-db-3-s",
  storageBucket: "danilo-fatec-db-3-s.firebasestorage.app",
  messagingSenderId: "546349013926",
  appId: "1:546349013926:web:848e1b52b7823256ee4d67"
};

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const db = getFirestore(app);