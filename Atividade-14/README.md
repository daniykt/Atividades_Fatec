# Atividade 14 — Geolocalização e GPS

Disciplina: Programação para Dispositivos Móveis I (Flutter)
Professor: Diego Menegassi

## Tema

Uso do pacote [`geolocator`](https://pub.dev/packages/geolocator) para verificação
de serviço de localização e permissões, captura única de coordenadas
(`getCurrentPosition`) e rastreamento contínuo (`getPositionStream`), com
tratamento defensivo de erros (GPS desativado, permissão negada e negada
permanentemente).

## Estrutura de pastas

```
lib/
├── services/
│   └── location_service.dart   # regras de permissão/serviço e acesso ao geolocator
├── screens/
│   └── geolocalizacao_screen.dart  # tela "Check-in & GPS"
└── main.dart
```

## Desafios implementados

- **Básico — Medidor de precisão:** `Chip` ao lado do título do card de
  localização, verde (`< 15m`), âmbar (`15–50m`) ou vermelho (`> 50m`), com
  texto e ícone indicando a qualidade do sinal.
- **Intermediário — Distância até a Fatec Matão:** cálculo com
  `Geolocator.distanceBetween`, exibido em metros (`< 1000m`) ou em km
  (1 casa decimal, `>= 1000m`). As coordenadas da Fatec Matão estão como
  constantes no topo de `geolocalizacao_screen.dart`
  (`kFatecMataoLatitude` / `kFatecMataoLongitude`) para fácil ajuste.
  **Atenção:** o endereço oficial (Av. Habib Gabriel, 1360, Residencial
  Olívio Benassi, Matão/SP, CEP 15990-539) foi confirmado no site
  institucional da Fatec Matão, mas as coordenadas exatas do prédio não
  são publicadas em nenhuma fonte oficial. O valor usado é uma
  aproximação de nível de rua obtida via geocodificação (OpenStreetMap/
  Nominatim) e deve ser conferido/ajustado se for necessária precisão
  exata.
- **Avançado — Abrir no Google Maps:** botão "Abrir no Mapa" (habilitado
  somente quando há posição capturada), usando `url_launcher` para abrir
  `https://maps.google.com/?q=lat,lng` em app externo, com `SnackBar` de
  erro caso o lançamento falhe.

## Como executar

```bash
cd Atividade-14
flutter pub get
flutter run
```

Sem emulador Android conectado, é possível testar via navegador:

```bash
flutter run -d chrome
```

No Chrome, o navegador solicitará permissão de localização; o rastreamento
contínuo usa a geolocalização do próprio navegador.

## Permissões

As permissões de localização (`ACCESS_FINE_LOCATION` e
`ACCESS_COARSE_LOCATION`) e a declaração de `<queries>` para abrir links
`https` (necessária no Android 11+ para o `url_launcher`) estão
configuradas em `android/app/src/main/AndroidManifest.xml`.
