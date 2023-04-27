import 'package:flutter/cupertino.dart';

abstract class ViewModelBase extends ChangeNotifier {
  ViewState _state = ViewState.IDLE;

  ViewState get state => _state;

  set state(ViewState state) {
    _state = state;
    notifyListeners();
  }

  String _errorMsg = "";

  String get errorMsg => _errorMsg;

  set errorMsg(String errorMsg) {
    _errorMsg = errorMsg;
  }

  void clearMsg() {
    _errorMsg = "";
  }

  bool get isStateLoading => _state == ViewState.BUSY;
}

enum ViewState {
  IDLE,
  BUSY
}