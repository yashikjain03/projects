import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App - UE213104',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Question> _questions = [
    Question(
      text: 'Which is the largest ocean in the world?',
      options: ['Atlantic Ocean', 'Pacific Ocean', 'Indian Ocean', 'Arctic Ocean'],
      correctOptionIndex: 1,
    ),
    Question(
      text: 'What is the chemical symbol for gold?',
      options: ['Go', 'Gd', 'Au', 'Ag'],
      correctOptionIndex: 2,
    ),
    Question(
      text: 'Which planet is known as the "Red Planet"?',
      options: ['Mars', 'Venus', 'Jupiter', 'Saturn'],
      correctOptionIndex: 0,
    ),
    Question(
      text: 'What is the capital of Australia?',
      options: ['Sydney', 'Melbourne', 'Canberra', 'Perth'],
      correctOptionIndex: 2,
    ),
    Question(
      text: 'Who wrote the play "Romeo and Juliet"?',
      options: ['William Shakespeare', 'Jane Austen', 'Mark Twain', 'Charles Dickens'],
      correctOptionIndex: 0,
    ),
  ];

  void _answerQuestion(int selectedOptionIndex) {
    if (selectedOptionIndex == _questions[_currentQuestionIndex].correctOptionIndex) {
      setState(() {
        _score++;
      });
    }
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // Reached the end of the quiz
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScoreScreen(score: _score)),
      );
    }
  }

  void _goToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // Reached the end of the quiz
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScoreScreen(score: _score)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App - UE213104'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              question.text,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            ...question.options.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final option = entry.value;
                return ElevatedButton(
                  onPressed: () => _answerQuestion(index),
                  child: Text(option),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToNextQuestion,
        child: Icon(Icons.forward),
      ),
    );
  }
}

class ScoreScreen extends StatelessWidget {
  final int score;

  const ScoreScreen({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App - UE213104'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/welldone.jpg'),
            SizedBox(height: 16.0),
            Text(
              'Score: $score / 5',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final int correctOptionIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctOptionIndex,
  });
}
