import 'package:event_broker/event_broker.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {
      // awesome = Awesome();
    });

    test('First Test', () {
      expect(() => EventBroker.test(), returnsNormally);
    });
  });
}
