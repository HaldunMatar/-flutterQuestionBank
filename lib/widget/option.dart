import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  Widget widget;
  Option(this.widget, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      print('constraints.maxHeight ${constraints.maxHeight}');
      return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 5,
          height: MediaQuery.of(context).size.height / 5,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              //// child: FittedBox(
              child: Center(child: widget),
              // ),
            ),
            color: Colors.green[500],
          ),
        ),
      );
    });
  }
}
