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
    if (_errorLocation == null) {
      // no location specified
      return 'Error (EventNotifier): ' + _message;
    } else {
      return 'Error (EventNotifier:$_errorLocation): ' + _message;
    }
  }
}
