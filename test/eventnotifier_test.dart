import 'package:eventnotifier/eventnotifier.dart';
import 'package:test/test.dart';

void main() {
  group('EventNotifier', () {
    // setUp(() {
    //   // awesome = Awesome();
    // });

    test('Static test', () {
      expect(() => EventNotifier.test(), returnsNormally);
    });
  });
}
