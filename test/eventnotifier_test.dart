import 'package:eventnotifier/eventnotifier.dart';
import 'package:test/test.dart';

void main() {
  group('EventNotifier', () {
    test('Static test', () {
      expect(() => EventNotifier.test(), returnsNormally);
    });
  });
}
