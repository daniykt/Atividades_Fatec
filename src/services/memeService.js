const STORAGE_KEY = 'memes_app';

export const getMemes = () => {
  const stored = localStorage.getItem(STORAGE_KEY);
  if (stored) return JSON.parse(stored);
  return [];
};

const saveMemes = (memes) => {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(memes));
};

export const addMeme = async (memeData) => {
  await new Promise(resolve => setTimeout(resolve, 500));
  const memes = getMemes();
  const newMeme = {
    id: Date.now(),
    title: memeData.title,
    author: memeData.author,
    imageDataUrl: memeData.imageDataUrl,
    createdAt: new Date().toISOString(),
  };
  const updatedMemes = [newMeme, ...memes];
  saveMemes(updatedMemes);
  return newMeme;
};

// (Comentários para futura integração Supabase iguais ao original)