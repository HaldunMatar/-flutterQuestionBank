import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'question.dart';

class Questions with ChangeNotifier {
  int _itemCount = 0;
  List<int> listquestionId = [];
  late Question currenntQuestion;
  static const basicUrl = '10.0.2.2:8081';

  Questions() {
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
    return listquestionId;
  }

  Future<void> fetchQuestion(int id) async {
    late Question question;
    print('fetchQuestion fetchQuestion ');
    var url = Uri.http(basicUrl, '/questions/${id}');
    List<int>? listQuestionId = null;
    try {
      var responRes = await http.get(url);
      const Utf8Codec utf8 = Utf8Codec();
      if (responRes.statusCode == 200) {
        final jsonResponRes =
            convert.jsonDecode(utf8.decode(responRes.bodyBytes)) as Map;

        //currenntQuestion = jsonResponRes as Quest;
        print('name name name     ${jsonResponRes['name']}');

        question = Question(
            id: jsonResponRes['id'],
            name: jsonResponRes['name'],
            option1: jsonResponRes['option1'],
            option2: jsonResponRes['option2'],
            option3: jsonResponRes['option3'],
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
    notifyListeners();
  }
}
