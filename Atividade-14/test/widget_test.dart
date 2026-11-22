import 'package:flutter_test/flutter_test.dart';

import 'package:pdm_aula14_gps/main.dart';

void main() {
  testWidgets('Tela inicial exibe o título Check-in & GPS', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Check-in & GPS'), findsOneWidget);
    expect(find.text('Capturar Localização Atual'), findsOneWidget);
  });
}
