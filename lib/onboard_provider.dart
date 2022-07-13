import 'package:flutter/widgets.dart';

class OnBoardProvider extends ChangeNotifier {
  bool isChecked = false;

  void changeChecked() {
    isChecked = !isChecked;
    notifyListeners();
  }
}
