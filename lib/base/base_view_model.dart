import 'package:flutter/cupertino.dart';

abstract class BaseViewModel<N> extends ChangeNotifier {
  bool _showLoading = false;

  bool get showLoading => _showLoading;

  late N _navigator;

  N getNavigator() => _navigator;

  void setNavigator(N navigator) {
    this._navigator = navigator;
  }

  set showLoading(bool value) {
    _showLoading = value;
    notifyListeners();
  }
}
