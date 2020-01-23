# EventNotifier

[![Pub Package](https://img.shields.io/pub/v/eventnotifier.svg?style=flat-square)](https://pub.dev/packages/eventnotifier)

Broadcasts named events to interested subscribers. When an event occurs, a method (callback) associated with the subscriber is executed.

EventNotifier is an implementation of the Observer Pattern, providing the ability to publish events, and subscribe to them elsewhere. Such implementations are sometimes called an 'Event Broker' or 'Event Bus'.

This is primarily intended to be mixed-in with a problem domain model, to enable it to provide change notifications.

## Background

It can be ideal to model problems or systems independent of _user interfaces_ (UI) or _system interfaces_ (SI). Doing so, one can model the problem or system without regard to how the model may (or may not be) consumed.

However, given an independent model, how can something else outside it know if something in the domain model changed?  The answer is to use `EventNotifier`.

### An Illustration

Consider that one wanted to model the operation of a single 'Elevator'. One might produce an independent domain model in object-oriented Dart code that modeled it.

Later, one might want to provide a user interface (UI) that let one interact with the model, or provide a system interface (SI) that interacted with (for example) the [Programmable Logic Controller (PLC)][plc] of a real-life Elevator.

In order to let external modules or systems know that the Elevator changed _floors_, the Elevator model can notify them through `EventNotifier`, so they can react as appropriate.

## See also

[Event] - Create lightweight custom Dart Events. An alternative to this centralized Event Bus/Event Broker approach.

## Dependencies

None. This Dart package has no non-development dependencies on any other packages.

## Usage

A simple example (see the  static EventNotifier test method):

```dart
import 'package:eventnotifier/eventnotifier.dart';

main() {
    var e = EventNotifier();

    e.subscribe('myChange', (_) => print('boom'));
    e.subscribe('myChange', (args) => print(args['pi']));

    // number of event names
    assert(e.count() == 1);
    // number of handlers subscribed to the event name
    assert(e.count('myChange') == 2);

    // indicate that event 'myChange' has occured
    // rguments are only required if a subscriber
    // expects one or more
    e.notify('myChange', {'pi': 3.14159});

    // displays ...
    // boom
    // 3.14159
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/aryehof/eventnotifier/issues
[event]: https://pub.dev/packages/event
[plc]: https://en.wikipedia.org/wiki/programmable_logic_controller
