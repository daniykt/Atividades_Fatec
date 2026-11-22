import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/media_service.dart';
import 'foto_tela_cheia_screen.dart';

const String _heroTagFotoPerfil = 'foto_perfil_hero';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final MediaService _mediaService = MediaService();
  final TextEditingController _nomeController = TextEditingController(
    text: 'Danilo da Silva Pereira',
  );

  Uint8List? _bytesImagem;

  @override
  void initState() {
    super.initState();
    _carregarFotoSalva();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  Future<void> _carregarFotoSalva() async {
    final base64 = await _mediaService.obterFotoBase64();
    if (!mounted) return;
    if (base64 != null) {
      setState(() {
        _bytesImagem = base64Decode(base64);
      });
    }
  }

  Future<void> _processarFotoEscolhida(XFile? foto) async {
    if (foto == null) return;
    final bytes = await foto.readAsBytes();
    if (!mounted) return;
    setState(() {
      _bytesImagem = bytes;
    });
    await _mediaService.salvarFotoBase64(base64Encode(bytes));
  }

  Future<void> _tirarFoto() async {
    Navigator.pop(context);
    final foto = await _mediaService.tirarFoto();
    if (!mounted) return;
    await _processarFotoEscolhida(foto);
  }

  Future<void> _selecionarDaGaleria() async {
    Navigator.pop(context);
    final foto = await _mediaService.selecionarDaGaleria();
    if (!mounted) return;
    await _processarFotoEscolhida(foto);
  }

  Future<void> _removerFoto() async {
    Navigator.pop(context);
    setState(() {
      _bytesImagem = null;
    });
    await _mediaService.removerFotoBase64();
  }

  void _abrirOpcoesFoto() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tirar Foto com a Câmera'),
                onTap: _tirarFoto,
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Escolher da Galeria'),
                onTap: _selecionarDaGaleria,
              ),
              if (_bytesImagem != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text(
                    'Remover Foto',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: _removerFoto,
                ),
            ],
          ),
        );
      },
    );
  }

  void _abrirFotoEmTelaCheia() {
    final bytes = _bytesImagem;
    if (bytes == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FotoTelaCheiaScreen(
          bytesImagem: bytes,
          heroTag: _heroTagFotoPerfil,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: _bytesImagem != null ? _abrirFotoEmTelaCheia : null,
                  child: Hero(
                    tag: _heroTagFotoPerfil,
                    child: CircleAvatar(
                      radius: 70,
                      child: _bytesImagem != null
                          ? ClipOval(
                              child: Image.memory(
                                _bytesImagem!,
                                width: 140,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(Icons.person, size: 70),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: FloatingActionButton.small(
                    backgroundColor: Colors.pink,
                    onPressed: _abrirOpcoesFoto,
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome Completo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
