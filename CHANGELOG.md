# Changelog

## Version 1.1.1  (2020-01-23)

- Added recommendation to generally use the [Event] package to the README.
- Added licence header to source files.

## Version 1.1.0  (2020-01-23)

- Removed references to EventSubscriber, as it now supports [Event] rather than EventNotifier


## Version 1.0.5  (2020-01-14)

- Add support again for optional event arguments (was previously removed).
Arguments should now be supplied as a Map, e.g. notify('myEvent', {'age': 32});
- A more detailed error is shown if a subscriber expects an argument, but
it isn't supplied when notified.
- One can now access the EventNotifier using the getEventNotifier() method.
Getting the instance can be useful from within a mixin.

## Version 1.0.4  (2020-01-13)

- Fixed LICENSE reference to package

## Version 1.0.3  (2020-01-13)

- Package example updated to show the static test() method.
- Add a link to EventSubscriber in the README.

## Version 1.0.2  (2020-01-12)

- Removed support for optional event arguments. Query the model instead.
- Exceptions are now also output to the console.
- README describes how to use Flutter with EventNotifier

## Version 1.0.1  (2020-01-11)

- Improved README and minor reformatting changes

## Version 1.0.0  (2020-01-11)

- Initial release

[event]: https://pub.dev/packages/event
