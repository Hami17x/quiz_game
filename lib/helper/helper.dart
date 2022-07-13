import 'dart:math';

import '../game/model/question_model.dart';

class Helper {
  static getRandoms(Option value) {
    final list = options.toList()..shuffle();
    var list2 = list.take(4).toList();

    bool x = list2.any((element) => element.text == value.text);

    if (x) {
      return list2;
    } else if (!x) {
      list2[Random().nextInt(4)] = value;
      return list2;
    }
  }
}
