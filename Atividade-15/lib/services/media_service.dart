import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MediaService {
  static const String keyFotoPerfil = 'key_foto_perfil';

  final ImagePicker _picker = ImagePicker();

  Future<XFile?> tirarFoto() async {
    return _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 1080,
    );
  }

  Future<XFile?> selecionarDaGaleria() async {
    return _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1080,
    );
  }

  Future<void> salvarFotoBase64(String base64) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyFotoPerfil, base64);
  }

  Future<String?> obterFotoBase64() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyFotoPerfil);
  }

  Future<void> removerFotoBase64() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyFotoPerfil);
  }
}
