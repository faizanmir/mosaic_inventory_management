import 'package:flutter/material.dart';
import 'package:mosaic_inventory_management/app_state_view_model.dart';
import 'package:mosaic_inventory_management/item_category/ui/category_screen.dart';
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
  final AppStateViewModel _appStateViewModel = AppStateViewModel();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder<bool>(
      future: _appStateViewModel.checkForLoginCredentials(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return (snapshot.connectionState == ConnectionState.done)
            ? (snapshot.data!)
                ? const CategoryListing()
                : const LoginScreen()
            : Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [CircularProgressIndicator()],
                ),
              );
      },
    ));
  }
}
