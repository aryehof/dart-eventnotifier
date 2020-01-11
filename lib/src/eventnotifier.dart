import 'dart:async';

import 'package:eventnotifier/src/error.dart';

typedef NotificationCallback = void Function(List<dynamic> args);

/// Broadcasts named events to interested subscribers.
/// When an event occurs, a method (callbacks) associated with the subscriber is executed.
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
  /// An optional list of arguments can be atached to the notification
  /// e.g. myEventNotifier.notify('valueChanged', [99, 'something else']);
  void notify(String eventName, [List<dynamic> args]) {
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

        // Convert the Set to a List before executing each listener. This
        // prevents errors that can arise if a listener removes itself during
        // invocation!
        _eventMap[eventName].toList().forEach((NotificationCallback callback) => callback(args));
        // print('notify: called handler for "$eventName" with args: $args');
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

  /// Example test of EventNotifier code
  static void test() {
    var e = EventNotifier();
    e.subscribe('mine', (_) => print('boom'));
    e.subscribe('mine', (args) => print(args[0]));
    assert(e.count() == 1);
    assert(e.count('mine') == 2);
    e.notify('mine', [99]);
  }
}
