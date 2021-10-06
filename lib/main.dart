import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mosaic_inventory_management/services/service_locator.dart';

import 'login/ui/login_ui.dart';

void main() {
  setupServices();
  runApp(const App());
}


class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }
}


