import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:question_bank/providers/competition.dart';

import 'package:question_bank/providers/question.dart';
import 'package:question_bank/providers/questions.dart';
import 'package:question_bank/widget/option.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Competition',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Competition'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  int _itemCount = 10;

  String _name = '';
  String _option1 = '';
  String _option2 = '';
  String _option3 = '';
  String _option4 = '';

  void _incrementCounter() {
    //fetchQuestions();
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Questions(),
          ),
          ChangeNotifierProvider.value(
            value: Competition(),
          ),
        ],
        child: Consumer<Questions>(
            builder: (ctx, questions, _) => Scaffold(
                  appBar: AppBar(
                    // Here we take the value from the MyHomePage object that was created by
                    // the App.build method, and use it to set our appbar title.
                    title: Text(widget.title),
                  ),
                  body: Center(
                    // Center is a layout widget. It takes a single child and positions it
                    // in the middle of the parent.
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        getQuestion(Text(
                          questions.currenntQuestion.getName,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Option(
                                        Text(
                                          questions.currenntQuestion.option1,
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        1,
                                        questions.checkAnswerAndSetPoint),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Option(
                                        Text(
                                          questions.currenntQuestion.option2,
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        2,
                                        questions.checkAnswerAndSetPoint),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Option(
                                        Text(
                                          questions.currenntQuestion.option3,
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        3,
                                        questions.checkAnswerAndSetPoint),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Option(
                                        Text(
                                          questions.currenntQuestion.option4,
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        4,
                                        questions.checkAnswerAndSetPoint),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: ElevatedButton(
                            onPressed: () async {
                              await fetchQuestion(questions);
                            },
                            child: Text('next'),
                          ),
                          // color: Colors.red[300],
                        ),
                        Card(
                          child: ElevatedButton(
                            onPressed: () async {
                              await questions.newCompetition();
                            },
                            child: Text('New'),
                          ),
                          // color: Colors.red[300],
                        ),
                        Text(
                          questions.numQuestion.toString(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          questions.numPoints.toString(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      fetchQuestion(questions);
                    },
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ), // This trailing comma makes auto-formatting nicer for build methods.
                )));
  }

  Future<void> fetchQuestion(Questions questions) async {
    print(" is in the range of");
    print(" is in the range of ");
    if (questions.currenntQuestion.isAnswered) {
      await questions.fetchQuestion();
    }
  }

  Widget getQuestion(Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Center(child: widget),
        ),
        color: Colors.pink,
      ),
    );
  }
}
