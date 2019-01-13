import './mutiple_choice_question.dart';

class MultipleQuiz {
  List<MultipleQuestion> _questions;
  int _currentQuestionIndex = -1;
  int _score = 0;

  MultipleQuiz(this._questions) {
    _questions.shuffle();
  }

  // keyword 'get' is like returning your variables when instantiating this class
  List get questions => _questions;
  int get length => _questions.length;
  int get questionNumber => _currentQuestionIndex + 1;
  int get score => _score;

  // return the next question from the list
  MultipleQuestion get nextQuestion {
    _currentQuestionIndex++;
    if (_currentQuestionIndex >= length) {
      return null;
    } else {
      return _questions[_currentQuestionIndex];
    }
  }

  void answer(bool isCorrect) {
    if (isCorrect) _score++;
  }
}
