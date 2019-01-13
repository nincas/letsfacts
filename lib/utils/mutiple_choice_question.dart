import 'package:html_unescape/html_unescape.dart';

class MultipleQuestion {
  final String question;
  List incorrectAnswers;
  final String correctAnswer;

  var htmlEscape = new HtmlUnescape();

  MultipleQuestion({this.question, this.incorrectAnswers, this.correctAnswer}) {
    List newList;
    htmlEscape.convert(this.question);
    htmlEscape.convert(this.correctAnswer);
  }
}
