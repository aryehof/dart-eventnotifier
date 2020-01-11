## EventNotifier

Broadcasts named events to interested subscribers. When an event occurs, a method (callbacks) associated with the subscriber is executed.

## Usage

A simple usage example (see the test static EventNotifier method):

```dart
import 'package:eventnotifier/eventnotifier.dart';

main() {
  var e = EventNotifier();
  e.subscribe('mine', (_) => print('boom'));
  e.subscribe('mine', (args) => print(args[0]));
  assert(e.count() == 1);
  assert(e.count('mine') == 2);
  e.notify('mine', [99]);
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
