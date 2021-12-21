import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'question.dart';

class Questions with ChangeNotifier {
  int _itemCount = 0;
  List<int> listquestionId = [];
  late Question currenntQuestion;
  static const basicUrl =
      'questionsbank-env.eba-cpsjg2rt.us-east-2.elasticbeanstalk.com';

  int numQuestion = 0;
  int numPoints = 0;
  int second = 1;

  Questions() {
    print('Questions Questions');
    currenntQuestion = Question.getBlackQuestion();
    fetchQuestions();
  }

  Future<List<int>?>? fetchQuestions() async {
    print(
        'fetchQuestions fetchQuestions fetchQuestions fetchQuestions fetchQuestions');
    var url = Uri.http(basicUrl, '/questions/');

    List<int>? listQuestionId = null;

    //var url = Uri.http('10.0.2.2:8081', '/questions/id/');
    // var url =
    //    Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

    try {
      var responRes = await http.get(url);
      print('fetchQuestions is fetchQuestions');
      if (responRes.statusCode == 200) {
        final jsonResponRes =
            convert.jsonDecode(responRes.body) as List<dynamic>;

        _itemCount = jsonResponRes.length;
        print('length is  ${_itemCount}');

        listquestionId =
            jsonResponRes.map<dynamic>((e) => e['id']).cast<int>().toList();
        print('list length ${listquestionId[100]}');
        /* jsonResponRes.forEach((element) {
          listQuestionId.add(element['id'])
          print(element['id']);
        });*/
      } else {
        print('there is errr in request with state${responRes.statusCode}');
      }
    } catch (error) {
      print(error.toString());
      // throw (error);
    }

    fetchQuestion();

    return listquestionId;
  }

  icreaseNumQuestion() {
    numQuestion++;
  }

  Future<void> fetchQuestion() async {
    if (numQuestion >= 10) return;
    late Question question;
    Random rnd;
    int min = 0;
    int max = listquestionId.length;
    rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    // print("$r is in the range of $min and $max");

    //await questions.fetchQuestion(questions.listquestionId[r]);

    // print('fetchQuestion fetchQuestion ');
    var url = Uri.http(basicUrl, '/questions/${listquestionId[r]}');
    List<int>? listQuestionId = null;
    try {
      var responRes = await http.get(url);
      const Utf8Codec utf8 = Utf8Codec();
      if (responRes.statusCode == 200) {
        final jsonResponRes =
            convert.jsonDecode(utf8.decode(responRes.bodyBytes)) as Map;

        //currenntQuestion = jsonResponRes as Quest;
        //  print('name name name     ${jsonResponRes['name']}');

        question = Question(
            id: jsonResponRes['id'],
            name: jsonResponRes['name'],
            option1: jsonResponRes['option1'],
            option2: jsonResponRes['option2'],
            option3: jsonResponRes['option3'],
            answer: jsonResponRes['answer'],
            option4: jsonResponRes['option4']);
      } else {
        print('there is errr in request with state ${responRes.statusCode}');

        question = Question.getBlackQuestion();
      }
    } catch (error) {
      print(error.toString());

      // throw (error);
    }
    currenntQuestion = question;
    icreaseNumQuestion();
    notifyListeners();
  }

  newCompetition() {
    numQuestion = 1;
    numPoints = 0;
    notifyListeners();
  }

  bool checkAnswerAndSetPoint(int numberOfOption) {
    bool res = currenntQuestion.checkAnswer(numberOfOption);
    // print(' befor numPoints$numPoints');
    if (res) {
      numPoints = numPoints + 10;
      //  print('after numPoints$numPoints');
      // notifyListeners();
    }

    return res;
  }
}
