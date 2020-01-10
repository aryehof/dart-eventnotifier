import 'dart:async';

typedef NotificationCallback = void Function(List<dynamic> args);

/// broadcasts events through a publish/subscribe pattern
class EventNotifier {
  final _eventMap = <String, List<NotificationCallback>>{};
  int _version = 0;
  int _microtaskVersion = 0;

  /// subscribe to a registered event, with the provided callback
  void addEvent(String eventName, NotificationCallback callback) {
    if (eventName.isEmpty) throw Exception('Error (subscribe): no eventName provided');
    if (callback == null) throw Exception('Error (subscribe): a callback is required');

    if (_eventMap.containsKey(eventName)) {
      _eventMap[eventName].add(callback);
    } else {
      _eventMap[eventName] = [callback];
    }
  }

  /// notify slisteners of a named event with an optional list of arguments
  void notify(String eventName, [List<dynamic> args]) {
    if (!_eventMap.containsKey(eventName)) {
      print('Info: call to notify event "$eventName" which has no listeners (EventNotifier)');
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
        print('notify: called handler for "$eventName" with args: $args');
      });
    }
  }

  /// remove the named event
  void remove(String eventName) {
    if (!_eventMap.containsKey(eventName))
      throw Exception('Error (remove): publish name ("$eventName") not found');

    _eventMap.remove(eventName);
  }

  /// get the number of named events
  int get count => _eventMap.length;

  // example test of object code
  static void test() {
    var b = EventNotifier();
    b.addEvent('mine', (_) => print('boom'));
    b.addEvent('mine', (args) => print(args[0]));
    assert(b.count == 1);
    b.notify('mine', [99]);
    // b.remove('mine');
    // assert(b.count == 0);
  }
}
