import 'package:flutter/foundation.dart';

class Question with ChangeNotifier {
  int id;

  String name;

  String option1;

  String option2;

  String option3;

  String option4;

  String? answer;

  Question({
    required this.id,
    required this.name,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    this.answer,
  });

  static Question getBlackQuestion() {
    return Question(
        id: -1, name: '', option1: '', option2: '', option3: '', option4: '');
    // Statement(s)
  }

  String get getName => name;
}

class OPtion {}

class OPtionString extends OPtion {}

class OPtionImage extends OPtion {}
