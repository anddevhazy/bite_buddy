// Development only: the entry point `serverpod start` launches. It enables the
// Flutter driver extension so tools (and agents) can drive the app, then runs
// the normal dev app from main.dart.
// ignore: depend_on_referenced_packages
import 'package:flutter_driver/driver_extension.dart';

import 'main.dart' as app;

void main() {
  enableFlutterDriverExtension(
    // Off so the app stays usable by hand; set to true to let a driver type
    enableTextEntryEmulation: false,
  );
  app.main();
}
