import 'package:eventnotifier/eventnotifier.dart';

// NOTE: EventNotifier is typically 'mixed-in' with a domain model

void main() {
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
