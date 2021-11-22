import 'dart:async';

import 'package:flutter/widgets.dart';

class Competition extends ChangeNotifier {
  int numQuestion = 0;
  int second = 1;

  void nextSecond() {
    second++;
  }
}
