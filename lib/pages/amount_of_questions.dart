import 'package:flutter/material.dart';
import './quiz_type_page.dart';
import './loading.dart';
import 'dart:async';

class TotalQuestions extends StatefulWidget {
  @override
  State createState() => TotalQuestionsState();
}

class TotalQuestionsState extends State<TotalQuestions> {
  String selected;
  String _difficulty = 'easy';
  bool stop = false;
  Timer _timer;

  List<DropdownMenuItem> selections() {
    int total = 5;
    List<DropdownMenuItem<String>> listSelection;

    listSelection = List.generate(total, (index) {
      var indexNew = (index + 1) * 10;
      return new DropdownMenuItem(
        value: indexNew.toString(),
        child: Center(
          child: Text(indexNew.toString(), style: TextStyle(fontSize: 30.0)),
        ),
      );
    });

    return listSelection.toList(growable: true);
  }

  // Difficulty
  List<DropdownMenuItem> difficulty() {
    int total = 3;
    List listDifficulty = ['Easy', 'Medium', 'Hard'];
    List<DropdownMenuItem<String>> listSelection;

    listSelection = List.generate(total, (index) {
      return new DropdownMenuItem(
        value: listDifficulty[index].toString().toLowerCase(),
        child: Center(
          child: Text(listDifficulty[index].toString(),
              style: TextStyle(fontSize: 30.0)),
        ),
      );
    });

    return listSelection.toList(growable: true);
  }

  startTimer() {
    _timer = new Timer(const Duration(seconds: 3), () {
      this.setState(() {
        stop = false;
      });
    });
  }

  handleSelect(val) {
    this.setState(() {
      selected = val;
    });
  }

  handleDifficulty(val) {
    this.setState(() {
      _difficulty = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blueAccent,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 110.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "     Select\nConfiguration",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: DropdownButton<String>(
                  items: this.difficulty(),
                  onChanged: this.handleDifficulty,
                  value: this._difficulty,
                  iconSize: 30.0,
                  hint: Center(
                    child: Text(
                      'CHOOSE DIFFICULTY',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: DropdownButton<String>(
                  items: selections(),
                  onChanged: this.handleSelect,
                  value: this.selected,
                  iconSize: 30.0,
                  hint: Center(
                    child: Text(
                      'CHOOSE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
              ),
              IconButton(
                icon: Icon(Icons.arrow_right),
                iconSize: 100.0,
                color: Colors.white,
                onPressed: () {
                  if (this.selected != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new QuizTypePage(this.selected, this._difficulty)));
                  } else {
                    this.setState(() {
                      stop = true;
                    });

                    this.startTimer();
                  }
                },
              ),
            ],
          ),
          this.stop == true
              ? Loading('Please choose number of questions.', 'stop')
              : Column(),
        ],
      ),
    );
  }
}
