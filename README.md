# EventNotifier

[![Pub Package](https://img.shields.io/pub/v/eventnotifier.svg?style=flat-square)](https://pub.dev/packages/eventnotifier)

Broadcasts named events to interested subscribers. When an event occurs, a method (callback) associated with the subscriber is executed.

EventNotifier is an implementation of the Observer Pattern, providing the ability to publish events, and subscribe to them elsewhere. Such implementations are sometimes called an 'Event Broker' or 'Event Bus'.

This is primarily intended to be mixed-in with a problem domain model, to enable it to provide change notifications.

## Background

It can be ideal to model problems or systems independent of _user interfaces_ (UI) or _system interfaces_ (SI). Doing so, one can model the problem or system without regard to how the model may (or may not be) consumed.

However, given an independent model, how can something else outside it know if something in the domain model changed?  The answer is to use `EventNotifier`.

## An Illustration

Consider that one wanted to model the operation of a single 'Elevator'. One might produce an independent domain model in object-oriented Dart code that modeled it.

Later, one might want to provide a user interface (UI) that let one interact with the model, or provide a system interface that interacted with (for example) the [Programmable Logic Controller (PLC)][plc] of a real-life Elevator (SI).

In order to let external modules or systems know that the Elevator changed _floors_, the Elevator model can notify them through `EventNotifier`, so they can react as appropriate.

## Dependencies

None. This Dart package has no non-development dependencies on any other packages.

## Flutter as User Interface (UI)

If one wants to use `Flutter` as a user interface for an independent domain model, then there needs to be some way for Widgets to be notified that something has changed in the domain model. In our Elevator example model, the Elevator might be changing floors, but how would your Flutter Widget displaying the current floor number know that and update?

The answer is to subscribe to an event in the domain model using an [EventSubscriber][eventsubscriber] Flutter widget.  This simple widget, allows one to subscribe to one or more named EventNotifier events. The Widget will be rebuilt when a subscribed event occurs, allowing some changing aspect of the model to be displayed in your Flutter user interface.

See [EventSubscriber][eventsubscriber]

## Usage

A simple example (see the  static EventNotifier test method):

```dart
import 'package:eventnotifier/eventnotifier.dart';

main() {
    var e = EventNotifier();

    e.subscribe('myChange', () => print('boom'));
    e.subscribe('myChange', () => print('another'));

    // number of event names
    assert(e.count() == 1);
    // number of handlers subscribed to the event name
    assert(e.count('myChange') == 2);
    
    // indicate that event 'myChange' has occured
    e.notify('myChange');

    // displays ...
    // boom
    // another
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/aryehof/eventnotifier/issues
[eventsubscriber]: http://example.com
[plc]: https://en.wikipedia.org/wiki/programmable_logic_controller
