
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Apa ibu kota negara Indonesia?',
      'options': ['Bandung', 'Jakarta', 'Surabaya', 'Medan'],
      'answer': 1,
    },
    {
      'question': 'Berapakah hasil dari 5 + 3?',
      'options': ['6', '7', '8', '9'],
      'answer': 2,
    },
    {
      'question': 'Bahasa yang digunakan Flutter adalah?',
      'options': ['Java', 'Python', 'Dart', 'C++'],
      'answer': 2,
    },
    {
      'question': 'Manakah yang termasuk perangkat input?',
      'options': ['Monitor', 'Printer', 'Speaker', 'Keyboard'],
      'answer': 3,
    },
    {
      'question': 'Apa kepanjangan dari CPU?',
      'options': [
        'Central Processing Unit',
        'Computer Personal Unit',
        'Central Program Utility',
        'Control Processing User',
      ],
      'answer': 0,
    },
  ];

  int _currentQuestionIndex = 0;
  int? _selectedAnswer;
  int _score = 0;
  bool _isFinished = false;

  Map<String, dynamic> get _currentQuestion =>
      _questions[_currentQuestionIndex];

  void _selectAnswer(int index) {
    if (_selectedAnswer != null || _isFinished) {
      return;
    }

    setState(() {
      _selectedAnswer = index;

      if (index == _currentQuestion['answer']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_selectedAnswer == null || _isFinished) {
      return;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
      });
    } else {
      setState(() {
        _isFinished = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Kuis selesai! Skor kamu: $_score/${_questions.length}',
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final options =
        _currentQuestion['options'] as List<String>;
    final correctAnswer = _currentQuestion['answer'] as int;
    final progress =
        (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${_currentQuestionIndex + 1} '
                  'of ${_questions.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${(progress * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 32),
            const Text(
              'Pertanyaan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _currentQuestion['question'] as String,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ...List.generate(options.length, (index) {
              return _buildOption(
                index: index,
                text: options[index],
                correctAnswer: correctAnswer,
              );
            }),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedAnswer == null || _isFinished
                    ? null
                    : _nextQuestion,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
                child: Text(
                  _isFinished
                      ? 'Kuis Selesai'
                      : _currentQuestionIndex == _questions.length - 1
                          ? 'Selesai'
                          : 'Berikutnya',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required int index,
    required String text,
    required int correctAnswer,
  }) {
    final isSelected = _selectedAnswer == index;
    final isCorrect = index == correctAnswer;
    final hasAnswered = _selectedAnswer != null;

    Color? cardColor;

    if (hasAnswered && isCorrect) {
      cardColor = Colors.green.withOpacity(0.15);
    } else if (hasAnswered && isSelected && !isCorrect) {
      cardColor = Colors.red.withOpacity(0.15);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: cardColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: hasAnswered && isCorrect
              ? Colors.green
              : hasAnswered && isSelected
                  ? Colors.red
                  : null,
          child: Text(
            String.fromCharCode(65 + index),
            style: TextStyle(
              color: hasAnswered && (isCorrect || isSelected)
                  ? Colors.white
                  : null,
            ),
          ),
        ),
        title: Text(text),
        trailing: hasAnswered && isCorrect
            ? const Icon(Icons.check_circle, color: Colors.green)
            : hasAnswered && isSelected
                ? const Icon(Icons.cancel, color: Colors.red)
                : null,
        onTap: () => _selectAnswer(index),
      ),
    );
  }
}
