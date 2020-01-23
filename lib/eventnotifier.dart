// Copyright 2020 Aryeh Hoffman. All rights reserved.
// Use of this source code is governed by an Apache-2.0 license that can be
// found in the LICENSE file.

/// An implementation in Dart of an 'Event Bus' or 'Event Broker'.
/// Broadcasts named events to interested subscribers. When an event occurs,
/// a method (callback) associated with the subscriber is executed.
library eventnotifier;

export 'src/eventnotifier.dart';
