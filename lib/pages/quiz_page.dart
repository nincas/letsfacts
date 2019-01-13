import 'package:flutter/material.dart';
// Import pages
import '../utils/question.dart';
import '../utils/quiz.dart';
import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';
import './score_page.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:html_unescape/html_unescape.dart';
import './loading.dart';

class QuizPage extends StatefulWidget {
  String _amount;
  String _difficulty;
  QuizPage(this._amount, this._difficulty);
  @override
  State createState() => new QuizPageState(this._amount, this._difficulty);
}

class QuizPageState extends State<QuizPage> {
  String amount_;
  String difficulty_;
  QuizPageState(this.amount_, this.difficulty_);
  Question currentQuestion;
  List data;
  Quiz quiz;
  List<Question> questionLists;

  // Like Promise function getting the data from API
  Future<List> getData() async {
    List<Question> listQuestions;
    var unescape = new HtmlUnescape();
    var url =
        "https://opentdb.com/api.php?amount=${this.amount_}&type=boolean&difficulty=${this.difficulty_.toLowerCase()}";
    print(url);
    var response = await http.get(Uri.encodeFull(url), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    }).catchError((err) {});

    var jsonData = json.decode(response.body);
    data = jsonData['results'];

    listQuestions = data.map((ques) {
      String questioN = ques['question'].toString();
      String b = ques['correct_answer'].toString().toLowerCase();
      bool ans = b == 'true';

      return new Question(question: unescape.convert(questioN), answer: ans);
    }).toList(growable: true);

    this.setState(() {
      quiz = new Quiz(listQuestions);
      currentQuestion = quiz.nextQuestion;
      questionText = currentQuestion.question;
      questionNumber = quiz.questionNumber;
      isLoading = false;
    });
  }

  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          // This our main page
          children: <Widget>[
            AnswerButton(true, () => handleAnswer(true)),
            isLoading == true
                ? Column()
                : QuestionText(questionText, questionNumber), // Question widget
            AnswerButton(false, () => handleAnswer(false))
          ],
        ),
        isLoading == true ? Loading('Loading...', 'wait') : Column(),
        overlayShouldBeVisible == true
            ? CorrectWrongOverlay(isCorrect, () {
                if (quiz.length == questionNumber) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ScorePage(quiz.score, quiz.length)),
                      (Route route) => route == null);
                  return;
                }
                currentQuestion = quiz.nextQuestion;
                this.setState(() {
                  overlayShouldBeVisible = false;
                  questionText = currentQuestion.question;
                  questionNumber = quiz.questionNumber;
                });
              })
            : Container()
      ],
    );
  }
}
