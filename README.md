EventNotifier

A publish/subscribe library.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'package:eventnotifier/eventnotifier.dart';

main() {
    var b = EventNotifier();
    b.register('mine');
    b.subscribe('mine', (_) => print('boom'));
    b.subscribe('mine', (args) => print(args[0]));
    assert(b.count == 1);
    b.publish('mine', [99]);
    b.remove('mine');
    assert(b.count == 0);
  }
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
