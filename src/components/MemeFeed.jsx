import MemeCard from './MemeCard';
import './MemeFeed.css';

const MemeFeed = ({ memes }) => {
  if (memes.length === 0) {
    return (
      <div className="empty-feed">
        <p>Nenhum meme por aqui ainda...</p>
        <p>Seja o primeiro a postar um meme! ⚡</p>
      </div>
    );
  }

  return (
    <div className="memes-grid">
      {memes.map((meme) => (
        <MemeCard key={meme.id} meme={meme} />
      ))}
    </div>
  );
};

export default MemeFeed;