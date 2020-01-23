import 'dart:async';

import 'package:eventnotifier/src/error.dart';

typedef NotificationCallback = void Function(Map<String, dynamic> args);

/// Broadcasts named events to interested subscribers.
/// When an event occurs, a method (callback) associated with the subscriber is executed.
class EventNotifier {
  final _eventMap = <String, List<NotificationCallback>>{};
  int _version = 0;
  int _microtaskVersion = 0;

  /// Subscribe the provided method (callback) to the specified named event.
  void subscribe(String eventName, NotificationCallback method) {
    if (eventName.isEmpty) throw NotifyException('no eventName provided', 'subscribe');
    if (method == null) throw NotifyException('a method (callback) is required', 'subscribe');

    if (_eventMap.containsKey(eventName)) {
      _eventMap[eventName].add(method);
    } else {
      _eventMap[eventName] = [method];
    }
  }

  /// Notify each subscriber that the specified named event has occured.
  /// An optional map of arguments can be attached to the notification
  /// e.g. myEventNotifier.notify('valueChanged', {'age': 32);
  void notify(String eventName, [Map<String, dynamic> args]) {
    // ignore if no subscribers
    if (!_eventMap.containsKey(eventName)) return;

    // Schedule a microtask to debounce multiple changes that can occur all at once.
    if (_microtaskVersion == _version) {
      _microtaskVersion++;
      scheduleMicrotask(() {
        _version++;
        _microtaskVersion = _version;

        // Convert the Set to a List before executing each callback. This
        // prevents errors that can arise if a callback removes itself during invocation
        try {
          _eventMap[eventName].toList().forEach((NotificationCallback callback) => callback(args));
        } on NoSuchMethodError {
          throw NotifyException(
              'an argument expected by a subscriber, was not included in the notification for event "$eventName"',
              'notify');
        }
      });
    }
  }

  /// Remove the named event's callback
  void remove(String eventName, NotificationCallback callback) {
    if (!_eventMap.containsKey(eventName))
      throw NotifyException('event name ("$eventName") not found', 'remove');

    _eventMap[eventName].remove(callback);
  }

  /// Gets the number of named events if no eventName is specified.
  /// If an eventName is specified, returns the number of subscribed handlers for that named event.
  int count([String eventName]) {
    if (eventName == null) {
      return _eventMap.length;
    } else {
      if (!_eventMap.containsKey(eventName))
        throw NotifyException('specified eventName not found', 'count');
      return _eventMap[eventName].length;
    }
  }

  // Get  the EventNotifier instance. Useful when EventNotifier is mixed-in with a domain model.
  EventNotifier getEventNotifier() {
    return this;
  }

  /// Test functionality, run EventNotifier.test()
  static void test() {
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
}
