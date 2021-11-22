import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Option extends StatefulWidget {
  Widget widget;
  int numberOfOption;
  Color? bgColor = Colors.amber[200];
  Function checkAnswer;
  Option(this.widget, this.numberOfOption, this.checkAnswer, {Key? key})
      : super(key: key);

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      print('constraints.maxHeight ${constraints.maxHeight}');
      return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 5,
          height: MediaQuery.of(context).size.height / 5,
          child: InkWell(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                //// child: FittedBox(
                child: Center(child: widget.widget),
                // ),
              ),
              color: widget.bgColor,
            ),
            onTap: () {
              if (widget.checkAnswer(widget.numberOfOption)) {
                setState(() {
                  widget.bgColor = Colors.green;
                });
              } else {
                setState(() {
                  widget.bgColor = Colors.red;
                });
              }
            },
          ),
        ),
      );
    });
  }
}
