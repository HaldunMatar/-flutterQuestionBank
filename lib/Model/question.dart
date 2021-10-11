// ignore: file_names
class Question {
  int id;

  String name;

  String ption1;

  String ption2;

  String ption3;

  String ption4;

  String? answer;

  Question({
    required this.id,
    required this.name,
    required this.ption1,
    required this.ption2,
    required this.ption3,
    required this.ption4,
    this.answer,
  });
}

class OPtion {}

class OPtionString extends OPtion {}

class OPtionImage extends OPtion {}
