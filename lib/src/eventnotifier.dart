import 'dart:async';

import 'package:eventnotifier/src/error.dart';

typedef VoidCallback = void Function();

/// Broadcasts named events to interested subscribers.
/// When an event occurs, a method (callback) associated with the subscriber is executed.
class EventNotifier {
  final _eventMap = <String, List<VoidCallback>>{};
  int _version = 0;
  int _microtaskVersion = 0;

  /// Subscribe the provided method (callback) to the specified named event.
  void subscribe(String eventName, VoidCallback method) {
    if (eventName.isEmpty) throw NotifyException('no eventName provided', 'subscribe');
    if (method == null) throw NotifyException('a method (callback) is required', 'subscribe');

    if (_eventMap.containsKey(eventName)) {
      _eventMap[eventName].add(method);
    } else {
      _eventMap[eventName] = [method];
    }
  }

  /// Notify each subscriber that the specified named event has occured.
  /// An optional list of arguments can be atached to the notification
  /// e.g. myEventNotifier.notify('valueChanged', [99, 'something else']);
  void notify(String eventName) {
    if (!_eventMap.containsKey(eventName)) {
      print(
          'Warning (EventNotifier:notify): event "$eventName" notified, which has no subscribers');
      return;
    }

    // We schedule a microtask to debounce multiple changes that can occur
    // all at once.
    if (_microtaskVersion == _version) {
      _microtaskVersion++;
      scheduleMicrotask(() {
        _version++;
        _microtaskVersion = _version;

        // Convert the Set to a List before executing each callback. This
        // prevents errors that can arise if a callback removes itself during invocation
        _eventMap[eventName].toList().forEach((VoidCallback callback) => callback());
        // print('notify: called handler for "$eventName" with args: $args');
      });
    }
  }

  /// Remove the named event's callback
  void remove(String eventName, VoidCallback callback) {
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

  /// Test EventNotifier functionality
  static void test() {
    var e = EventNotifier();
    e.subscribe('mine', () => print('boom'));
    e.subscribe('mine', () => print('another'));
    assert(e.count() == 1); // number of event names
    assert(e.count('mine') == 2); // number of handlers subscribed to the event name
    e.notify('mine');

    // displays ...
    // boom
    // another
  }
}
