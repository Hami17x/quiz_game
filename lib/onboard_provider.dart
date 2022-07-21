import 'package:flutter/widgets.dart';

class OnBoardProvider extends ChangeNotifier {
  bool isChecked = true;

  void changeChecked() {
    isChecked = !isChecked;
    notifyListeners();
  }
}
