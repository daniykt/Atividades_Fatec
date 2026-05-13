import { Calendar, User } from 'lucide-react';
import './MemeCard.css';

const MemeCard = ({ meme }) => {
  const formattedDate = new Date(meme.createdAt).toLocaleDateString('pt-BR', {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  });

  return (
    <div className="meme-card">
      <div className="meme-card-image">
        <img src={meme.imageDataUrl} alt={meme.title} />
      </div>
      <div className="meme-card-content">
        <h3 className="meme-card-title">{meme.title}</h3>
        <div className="meme-card-meta">
          <div className="meta-item">
            <User size={14} />
            <span>{meme.author}</span>
          </div>
          <div className="meta-item">
            <Calendar size={14} />
            <span>{formattedDate}</span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default MemeCard;