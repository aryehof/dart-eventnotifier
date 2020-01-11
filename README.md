# EventNotifier

Broadcasts named events to interested subscribers. When an event occurs, a method (callback) associated with the subscriber is executed.

EventNotifier is an implementation of the observer pattern, providing the ability to publish events, and subscribe to them elsewhere. Such implementations are sometimes called an 'Event Broker' or 'Event Bus'.

This is primarily intended to be mixed-in with a problem domain model to support change notifications.

There are no non-development dependencies on other packages.

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

[tracker]: https://github.com/aryehof/eventnotifier/issues
