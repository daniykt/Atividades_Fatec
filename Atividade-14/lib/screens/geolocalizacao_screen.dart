import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/location_service.dart';

// Coordenadas aproximadas (nível de rua, via OpenStreetMap/Nominatim) da
// Fatec Matão - Av. Habib Gabriel, 1360, Matão/SP. Ajuste aqui se tiver um
// valor mais preciso (ex: coletado no pino do Google Maps).
const double kFatecMataoLatitude = -21.6206655;
const double kFatecMataoLongitude = -48.3603501;

class GeolocalizacaoScreen extends StatefulWidget {
  const GeolocalizacaoScreen({super.key});

  @override
  State<GeolocalizacaoScreen> createState() => _GeolocalizacaoScreenState();
}

class _GeolocalizacaoScreenState extends State<GeolocalizacaoScreen> {
  final LocationService _locationService = LocationService();

  Position? _posicaoAtual;
  bool _carregando = false;
  String? _mensagemErro;
  StreamSubscription<Position>? _positionStreamSub;
  bool _rastreando = false;

  @override
  void dispose() {
    _positionStreamSub?.cancel();
    super.dispose();
  }

  Future<void> _buscarLocalizacao() async {
    setState(() {
      _carregando = true;
      _mensagemErro = null;
    });

    try {
      final posicao = await _locationService.obterPosicaoAtual();
      if (!mounted) return;
      setState(() {
        _posicaoAtual = posicao;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _mensagemErro = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _carregando = false;
        });
      }
    }
  }

  void _alternarRastreamento() {
    if (_rastreando) {
      _positionStreamSub?.cancel();
      _positionStreamSub = null;
      setState(() {
        _rastreando = false;
      });
      return;
    }

    setState(() {
      _rastreando = true;
      _mensagemErro = null;
    });

    _positionStreamSub = _locationService.monitorarPosicao().listen(
      (posicao) {
        if (!mounted) return;
        setState(() {
          _posicaoAtual = posicao;
        });
      },
      onError: (erro) {
        if (!mounted) return;
        setState(() {
          _mensagemErro = erro.toString().replaceFirst('Exception: ', '');
          _rastreando = false;
        });
      },
    );
  }

  Future<void> _abrirNoMapa() async {
    final posicao = _posicaoAtual;
    if (posicao == null) return;

    final uri = Uri.parse(
      'https://maps.google.com/?q=${posicao.latitude},${posicao.longitude}',
    );

    bool abriu = false;
    try {
      abriu = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      abriu = false;
    }

    if (!mounted) return;
    if (!abriu) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o mapa.')),
      );
    }
  }

  String _formatarDistancia(double metros) {
    if (metros < 1000) {
      return '${metros.toStringAsFixed(1)} m';
    }
    return '${(metros / 1000).toStringAsFixed(1)} km';
  }

  Widget _buildChipPrecisao(double precisao) {
    Color cor;
    String texto;
    IconData icone;

    if (precisao < 15) {
      cor = Colors.green;
      texto = 'Precisão boa';
      icone = Icons.gps_fixed;
    } else if (precisao <= 50) {
      cor = Colors.amber;
      texto = 'Precisão média';
      icone = Icons.gps_not_fixed;
    } else {
      cor = Colors.red;
      texto = 'Precisão baixa';
      icone = Icons.gps_off;
    }

    return Chip(
      avatar: Icon(icone, color: Colors.white, size: 18),
      label: Text(texto, style: const TextStyle(color: Colors.white)),
      backgroundColor: cor,
    );
  }

  Widget _buildCardErro() {
    return Card(
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _mensagemErro!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardPosicao(Position posicao) {
    final distancia = Geolocator.distanceBetween(
      posicao.latitude,
      posicao.longitude,
      kFatecMataoLatitude,
      kFatecMataoLongitude,
    );

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Localização Atual',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildChipPrecisao(posicao.accuracy),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.my_location, color: Colors.blue),
            title: const Text('Latitude'),
            subtitle: Text(posicao.latitude.toStringAsFixed(6)),
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.green),
            title: const Text('Longitude'),
            subtitle: Text(posicao.longitude.toStringAsFixed(6)),
          ),
          ListTile(
            leading: const Icon(Icons.speed, color: Colors.orange),
            title: const Text('Precisão / Altitude'),
            subtitle: Text(
              'Precisão: ${posicao.accuracy.toStringAsFixed(1)}m | '
              'Alt: ${posicao.altitude.toStringAsFixed(1)}m',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.social_distance, color: Colors.purple),
            title: const Text('Distância até a Fatec Matão'),
            subtitle: Text(_formatarDistancia(distancia)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: _abrirNoMapa,
                icon: const Icon(Icons.map),
                label: const Text('Abrir no Mapa'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-in & GPS'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (_carregando)
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(),
                    ),
                  if (_mensagemErro != null) _buildCardErro(),
                  if (_mensagemErro != null) const SizedBox(height: 16),
                  if (_posicaoAtual != null) _buildCardPosicao(_posicaoAtual!),
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _carregando ? null : _buscarLocalizacao,
                      icon: const Icon(Icons.my_location),
                      label: const Text('Capturar Localização Atual'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _alternarRastreamento,
                      icon: Icon(_rastreando ? Icons.stop : Icons.play_arrow),
                      label: Text(
                        _rastreando
                            ? 'Parar Rastreamento'
                            : 'Iniciar Rastreamento Contínuo',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
