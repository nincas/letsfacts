import 'package:flutter/material.dart';
import './quiz_page.dart';
import './quiz_multiple_choice.dart';

class QuizTypePage extends StatelessWidget {
  final String noitems;
  final String difficulty;
  QuizTypePage(this.noitems, this.difficulty);

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: Material(
                color: Colors.orangeAccent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            QuizMultipleChoicePage(
                                this.noitems, this.difficulty)));
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Multiple Choice",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Material(
                color: Colors.greenAccent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            QuizPage(this.noitems, this.difficulty)));
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "True or False",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
