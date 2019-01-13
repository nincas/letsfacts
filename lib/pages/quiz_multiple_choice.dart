import 'package:flutter/material.dart';
import '../UI/question_text.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:html_unescape/html_unescape.dart';
import './loading.dart';
import '../utils/mutiple_choice_question.dart';
import '../utils/mutiple_choice.dart';
import '../UI/correct_wrong_overlay.dart';
import './score_page.dart';
import 'dart:math';

class QuizMultipleChoicePage extends StatefulWidget {
  final String noitem;
  final String difficulty;

  QuizMultipleChoicePage(this.noitem, this.difficulty);
  @override
  State createState() =>
      new QuizMultipleChoicePageState(this.noitem, this.difficulty);
}

class QuizMultipleChoicePageState extends State<QuizMultipleChoicePage>
    with SingleTickerProviderStateMixin {
  List<MultipleQuestion> questionsMultiple;
  List data;
  MultipleQuestion currentQuestion;
  MultipleQuiz quizMultiple;

  Animation<double> animation;
  AnimationController controller;

  final String noitem;
  final String difficulty;

  QuizMultipleChoicePageState(this.noitem, this.difficulty);

  Future<List> getData() async {
    var unescape = new HtmlUnescape();
    var url =
        "https://opentdb.com/api.php?amount=${this.noitem}&type=multiple&difficulty=${this.difficulty}";
    var response = await http.get(Uri.encodeFull(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }).catchError((err) {});

    var jsonData = json.decode(response.body);
    data = jsonData['results'];

    questionsMultiple = data.map((question) {
      List answers = new List();
      answers.add(question['correct_answer'].toString());
      for (var i = 0; i < question['incorrect_answers'].length; i++) {
        var incorrectAnswers = question['incorrect_answers'][i].toString();
        answers.add(unescape.convert(incorrectAnswers));
      }

      var answerC = question['correct_answer'].toString();
      var questionTxt = question['question'].toString();

      return new MultipleQuestion(
          question: unescape.convert(questionTxt),
          incorrectAnswers: answers,
          correctAnswer: unescape.convert(answerC));
    }).toList(growable: true);

    this.setState(() {
      quizMultiple = new MultipleQuiz(questionsMultiple);
      currentQuestion = quizMultiple.nextQuestion;
      questionString = currentQuestion.question;
      answers = currentQuestion.incorrectAnswers;
      correctAnswer = currentQuestion.correctAnswer;

      questionNumber = quizMultiple.questionNumber;
      isLoading = false;
      controller.forward();
    });
  }

  String questionString = "...";
  int questionNumber;
  bool isLoading = true;
  List answers = ['Loading..', 'Loading..', 'Loading..', 'Loading..'];
  bool isCorrect;
  String correctAnswer;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    this.getData();

    controller = new AnimationController(
        duration: Duration(milliseconds: 800), vsync: this);

    animation =
        new CurvedAnimation(parent: controller, curve: Curves.bounceOut);

    animation.addListener(() => this.setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleAnswer(String ans) {
    isCorrect = (currentQuestion.correctAnswer == ans);
    quizMultiple.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;
    double fontSize = animation.value * 18;
    EdgeInsets paddingSize = EdgeInsets.symmetric(horizontal: 20.0);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Material(
                      color: Colors.yellow[900],
                      child: InkWell(
                        onTap: () => this.handleAnswer(answers[0].toString()),
                        child: Container(
                          padding: paddingSize,
                          child: Center(
                            child: Text(
                              answers[0].toString(),
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      color: Colors.orange,
                      child: InkWell(
                        onTap: () => this.handleAnswer(answers[1].toString()),
                        child: Container(
                          padding: paddingSize,
                          child: Center(
                            child: Text(
                              answers[1].toString(),
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            QuestionText(questionString, questionNumber),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Material(
                      color: Colors.blue,
                      child: InkWell(
                        onTap: () => this.handleAnswer(answers[2].toString()),
                        child: Container(
                          padding: paddingSize,
                          child: Center(
                            child: Text(
                              answers[2].toString(),
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      color: Colors.green,
                      child: InkWell(
                        onTap: () => this.handleAnswer(answers[3].toString()),
                        child: Container(
                          padding: paddingSize,
                          child: Center(
                            child: Text(
                              answers[3].toString(),
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        isLoading == true ? Loading('Loading..', 'wait') : Container(),
        overlayShouldBeVisible == true
            ? CorrectWrongOverlay(isCorrect, () {
                if (quizMultiple.length == questionNumber) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => ScorePage(
                              quizMultiple.score, quizMultiple.length)),
                      (Route route) => route == null);
                  return;
                }
                currentQuestion = quizMultiple.nextQuestion;
                this.setState(() {
                  questionString = currentQuestion.question;
                  answers = currentQuestion.incorrectAnswers;
                  correctAnswer = currentQuestion.correctAnswer;
                  questionNumber = quizMultiple.questionNumber;
                  overlayShouldBeVisible = false;
                });
              })
            : Container()
      ],
    );
  }
}
