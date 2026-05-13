import { useState } from 'react';
import { Upload, Image as ImageIcon, X } from 'lucide-react';
import './MemeForm.css';

const MemeForm = ({ onAddMeme }) => {
  const [title, setTitle] = useState('');
  const [author, setAuthor] = useState('');
  const [imageFile, setImageFile] = useState(null);
  const [previewUrl, setPreviewUrl] = useState('');
  const [isUploading, setIsUploading] = useState(false);

  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file && file.type.startsWith('image/')) {
      setImageFile(file);
      const reader = new FileReader();
      reader.onloadend = () => setPreviewUrl(reader.result);
      reader.readAsDataURL(file);
    } else {
      alert('Por favor, selecione uma imagem válida.');
    }
  };

  const clearPreview = () => {
    setImageFile(null);
    setPreviewUrl('');
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!title.trim() || !author.trim() || !imageFile) {
      alert('Preencha todos os campos e selecione uma imagem.');
      return;
    }

    setIsUploading(true);
    try {
      const reader = new FileReader();
      reader.onloadend = async () => {
        const memeData = {
          title: title.trim(),
          author: author.trim(),
          imageDataUrl: reader.result,
        };
        await onAddMeme(memeData);
        setTitle('');
        setAuthor('');
        setImageFile(null);
        setPreviewUrl('');
      };
      reader.readAsDataURL(imageFile);
    } catch (error) {
      console.error('Erro ao enviar meme:', error);
      alert('Erro ao publicar meme. Tente novamente.');
    } finally {
      setIsUploading(false);
    }
  };

  return (
    <form className="meme-form" onSubmit={handleSubmit}>
      <h2 className="form-title">
        <Upload size={24} />
        Postar novo meme
      </h2>

      <div className="form-group">
        <label>Título do meme</label>
        <input
          type="text"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          placeholder="Ex: Gato Confuso"
          required
        />
      </div>

      <div className="form-group">
        <label>Seu nome (quem postou)</label>
        <input
          type="text"
          value={author}
          onChange={(e) => setAuthor(e.target.value)}
          placeholder="Ex: João Memeiro"
          required
        />
      </div>

      <div className="form-group">
        <label>Imagem do meme</label>
        <div className="image-upload-area">
          <button
            type="button"
            className="upload-button"
            onClick={() => document.getElementById('meme-image-input').click()}
          >
            <ImageIcon size={18} />
            Escolher imagem
          </button>
          <input
            id="meme-image-input"
            type="file"
            accept="image/*"
            onChange={handleImageChange}
            style={{ display: 'none' }}
          />
          {previewUrl && (
            <div className="image-preview">
              <img src={previewUrl} alt="Preview" />
              <button type="button" className="remove-preview" onClick={clearPreview}>
                <X size={14} />
              </button>
            </div>
          )}
        </div>
      </div>

      <button type="submit" className="submit-button" disabled={isUploading}>
        {isUploading ? 'Publicando...' : 'Publicar meme'}
      </button>
    </form>
  );
};

export default MemeForm;