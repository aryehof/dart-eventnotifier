import 'dart:async';

typedef VoidCallback = void Function(List<dynamic> args);

class EventBroker {
  final _myMap = <String, List<VoidCallback>>{};
  int _version = 0;
  int _microtaskVersion = 0;

  /// register an event
  void register(String name) {
    if (name.isEmpty) throw Exception('Error (register): a name is required to register an event');
    if (_myMap.containsKey(name))
      throw Exception('Error (register): attempted to register a name that already exists');

    _myMap[name] = [];
  }

  /// subscribe to a registered event, with the provided callback
  void subscribe(String name, VoidCallback callback) {
    if (!_myMap.containsKey(name))
      throw Exception('Error (subscribe): provided name is not registered');
    if (callback == null) throw Exception('Error (subscribe): a callback is required');

    _myMap[name].add(callback);
  }

  /// publish an event with optional arguments
  void publish(String name, [List<dynamic> args]) {
    if (!_myMap.containsKey(name))
      throw Exception('Error (publish): publish name ("$name") not found');

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
        // _listeners.toList().forEach((VoidCallback listener) => listener());
        _myMap[name].toList().forEach((VoidCallback callback) => callback(args));
      });
    }
  }

  void remove(String name) {
    _myMap.remove(name);
  }

  int get count => _myMap.length;

  static void test() {
    var e = EventBroker();
    e.register('mine');
    e.subscribe('mine', (_) => print('boom'));
    e.subscribe('mine', (args) => print(args[0]));
    assert(e.count == 1);
    e.publish('mine', [99]);
  }
}
