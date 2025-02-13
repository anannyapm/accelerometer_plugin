import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:accelerometer_plugin/accelerometer_plugin.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Accelerometer stream test', (WidgetTester tester) async {
    // Listen to the accelerometer stream
    final stream = AccelerometerPlugin.accelerometerStream;

    // Wait for the first event from the stream
    final firstEvent = await stream.first;

    // Verify that the event contains valid x, y, z values
    expect(firstEvent['x'], isNotNull);
    expect(firstEvent['y'], isNotNull);
    expect(firstEvent['z'], isNotNull);

    // Print the values for debugging
    print(
        'Accelerometer Data: x=${firstEvent['x']}, y=${firstEvent['y']}, z=${firstEvent['z']}');
  });
}
