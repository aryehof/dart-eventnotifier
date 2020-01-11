## EventNotifier

Broadcasts named events to interested subscribers. When an event occurs, a method (callback) associated with the subscriber is executed.

This is primarily intended to be mixed-in with a domain model to support change notifications.

## Usage

A simple usage example (see the test static EventNotifier method):

```dart
import 'package:eventnotifier/eventnotifier.dart';

main() {
  var e = EventNotifier();
  e.subscribe('myevent', (_) => print('boom'));
  e.subscribe('myevent', (args) => print(args[0]));
  assert(e.count() == 1);
  assert(e.count('myevent') == 2);
  e.notify('myevent', [99]);

  // displays ...
  // boom
  // 99
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/aryehof/outira-eventnotifier/issues
