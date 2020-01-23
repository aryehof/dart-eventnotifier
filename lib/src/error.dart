// Copyright 2020 Aryeh Hoffman. All rights reserved.
// Use of this source code is governed by an Apache-2.0 license that can be
// found in the LICENSE file.

class NotifyException implements Exception {
  // The error message to display
  String _message;

  /// The program location of the error, e.g. the method name (optional)
  String _errorLocation;

  NotifyException(String message, [String errorLocation]) {
    _message = message;
    _errorLocation = errorLocation;
  }

  @override
  String toString() {
    var fullMessage;

    if (_errorLocation == null) {
      // no location specified
      fullMessage = 'Error (EventNotifier): ' + _message;
    } else {
      fullMessage = 'Error (EventNotifier:$_errorLocation): ' + _message;
    }

    print('message');
    return fullMessage;
  }
}
