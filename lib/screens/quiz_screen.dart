
import 'package:flutter/material.dart';
import 'result_screen.dart';

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

  Map<String, dynamic> get _currentQuestion =>
      _questions[_currentQuestionIndex];

  void _selectAnswer(int index) {
    if (_selectedAnswer != null) {
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
    if (_selectedAnswer == null) {
      return;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: _score,
            totalQuestions: _questions.length,
            onRetry: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuizScreen(),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> options =
        _currentQuestion['options'] as List<String>;
    final int correctAnswer = _currentQuestion['answer'] as int;
    final double progress =
        (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz App',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pertanyaan '
                          '${_currentQuestionIndex + 1} '
                          'dari ${_questions.length}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          '${(progress * 100).round()}%',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 3,
                      backgroundColor: const Color(0xFFEAEAEA),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    ),
                    const SizedBox(height: 36),
                    Text(
                      _currentQuestion['question'] as String,
                      style: const TextStyle(
                        fontSize: 23,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Pilih satu jawaban.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),
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
                        onPressed: _selectedAnswer == null
                            ? null
                            : _nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor:
                              const Color(0xFFE5E5E5),
                          disabledForegroundColor:
                              Colors.black45,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          _currentQuestionIndex ==
                                  _questions.length - 1
                              ? 'Selesai'
                              : 'Berikutnya',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOption({
    required int index,
    required String text,
    required int correctAnswer,
  }) {
    final bool hasAnswered = _selectedAnswer != null;
    final bool isSelected = _selectedAnswer == index;
    final bool isCorrect = index == correctAnswer;

    Color borderColor = const Color(0xFFE0E0E0);
    Color backgroundColor = Colors.white;

    if (isSelected) {
      borderColor = Colors.black;
      backgroundColor = const Color(0xFFF5F5F5);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: isSelected ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        trailing: hasAnswered && isSelected
            ? Text(
                isCorrect ? 'Benar' : 'Salah',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              )
            : null,
        onTap: () => _selectAnswer(index),
      ),
    );
  }
}
