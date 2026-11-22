import 'dart:typed_data';

import 'package:flutter/material.dart';

class FotoTelaCheiaScreen extends StatelessWidget {
  const FotoTelaCheiaScreen({
    super.key,
    required this.bytesImagem,
    required this.heroTag,
  });

  final Uint8List bytesImagem;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: heroTag,
          child: InteractiveViewer(
            child: Image.memory(bytesImagem),
          ),
        ),
      ),
    );
  }
}
