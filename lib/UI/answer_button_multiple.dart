import 'package:flutter/material.dart';

class AnswerButtonMultiple extends StatefulWidget {
  final String _answer;
  final _onTap;
  AnswerButtonMultiple(this._answer, this._onTap);
  @override
  State createState() => new AnswerButtonMultipleState();
}

class AnswerButtonMultipleState extends State<AnswerButtonMultiple>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;
    double fontSize = 18;
    EdgeInsets paddingSize = EdgeInsets.symmetric(horizontal: 20.0);

    return new Expanded(
      child: Material(
        color: Colors.yellow[900],
        child: InkWell(
          onTap: () => widget._onTap,
          child: Container(
            padding: paddingSize,
            child: Center(
              child: Text(
                widget._answer,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
