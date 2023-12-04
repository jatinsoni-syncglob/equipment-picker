import 'package:flutter_test/flutter_test.dart';
import 'package:equipment_picker/main.dart';

void main() {
  testWidgets('Equipment Picker App test', (WidgetTester tester) async {
    await tester.pumpWidget(const EquipmentPickerApp());
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });
}
