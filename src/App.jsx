import { useState, useEffect } from 'react';
import MemeForm from './components/MemeForm';
import MemeFeed from './components/MemeFeed';
import { getMemes, addMeme } from './services/memeService';
import { Sparkles } from 'lucide-react';
import './App.css';

function App() {
  const [memes, setMemes] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchMemes = async () => {
      const loadedMemes = await getMemes();
      setMemes(loadedMemes);
      setLoading(false);
    };
    fetchMemes();
  }, []);

  const handleAddMeme = async (memeData) => {
    const newMeme = await addMeme(memeData);
    setMemes((prev) => [newMeme, ...prev]);
  };

  return (
    <div className="app">
      <div className="container">
        <header className="app-header">
          <div className="logo">
            <Sparkles size={36} />
            <h1>MemeVerso</h1>
          </div>
          <p className="subtitle">Poste seu meme e veja o que a galera está rindo</p>
        </header>

        <MemeForm onAddMeme={handleAddMeme} />

        <section>
          <h2 className="section-title">🔥 Últimos memes postados</h2>
          {loading ? (
            <div className="loading-spinner">
              <div className="spinner"></div>
            </div>
          ) : (
            <MemeFeed memes={memes} />
          )}
        </section>
      </div>
    </div>
  );
}

export default App;