
import 'package:flutter/material.dart';
import '../widgets/quiz_option.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with RestorationMixin {
  final RestorableInt _currentQuestionIndex = RestorableInt(0);
  final RestorableInt _selectedAnswer = RestorableInt(-1);
  final RestorableInt _score = RestorableInt(0);

  @override
  String? get restorationId => 'quiz_screen';

  @override
  void restoreState(
    RestorationBucket? oldBucket,
    bool initialRestore,
  ) {
    registerForRestoration(
      _currentQuestionIndex,
      'current_question',
    );
    registerForRestoration(
      _selectedAnswer,
      'selected_answer',
    );
    registerForRestoration(_score, 'quiz_score');
  }

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

  Map<String, dynamic> get _currentQuestion =>
      _questions[_currentQuestionIndex.value];

  void _selectAnswer(int index) {
    if (_selectedAnswer.value != -1) return;

    setState(() {
      _selectedAnswer.value = index;

      if (index == _currentQuestion['answer']) {
        _score.value++;
      }
    });
  }


  void _nextQuestion() {
  if (_selectedAnswer.value == -1) return;

  if (_currentQuestionIndex.value < _questions.length - 1) {
    setState(() {
      _currentQuestionIndex.value++;
      _selectedAnswer.value = -1;
    });
    return;
  }

  final int finalScore = _score.value;
  final int totalQuestions = _questions.length;

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => ResultScreen(
        score: finalScore,
        totalQuestions: totalQuestions,
      ),
    ),
  );
}


  @override
  void dispose() {
    _currentQuestionIndex.dispose();
    _selectedAnswer.dispose();
    _score.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double padding = width * 0.06;

    final double questionFontSize =
        (width * 0.058).clamp(20.0, 27.0);

    final double bodyFontSize =
        (width * 0.038).clamp(13.0, 16.0);

    final List<String> options =
        List<String>.from(_currentQuestion['options']);

    final int correctAnswer = _currentQuestion['answer'] as int;
    final bool hasAnswered = _selectedAnswer.value != -1;

    final double progress =
        (_currentQuestionIndex.value + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz App',
          style: TextStyle(
            fontSize: bodyFontSize * 1.15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - padding * 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/quiz_illustration.jpg',
                        width: width * 0.30,
                        height: width * 0.22,
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: width * 0.04),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pertanyaan '
                          '${_currentQuestionIndex.value + 1} '
                          'dari ${_questions.length}',
                          style: TextStyle(
                            fontSize: bodyFontSize,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          '${(progress * 100).round()}%',
                          style: TextStyle(
                            fontSize: bodyFontSize,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: width * 0.025),

                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 3,
                      backgroundColor: const Color(0xFFEAEAEA),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    ),

                    SizedBox(height: width * 0.07),

                    Text(
                      _currentQuestion['question'] as String,
                      style: TextStyle(
                        fontSize: questionFontSize,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: width * 0.06),

                    Text(
                      'Pilih satu jawaban.',
                      style: TextStyle(
                        fontSize: bodyFontSize,
                        color: Colors.black54,
                      ),
                    ),

                    SizedBox(height: width * 0.035),

                    ...List.generate(options.length, (index) {
                      final bool isSelected =
                          _selectedAnswer.value == index;

                      final String? feedback = isSelected
                          ? (index == correctAnswer
                              ? 'Benar'
                              : 'Salah')
                          : null;

                      return QuizOption(
                        text: options[index],
                        isSelected: isSelected,
                        feedback: feedback,
                        onTap: hasAnswered
                            ? null
                            : () => _selectAnswer(index),
                      );
                    }),

                    SizedBox(height: width * 0.025),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            hasAnswered ? _nextQuestion : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor:
                              const Color(0xFFE5E5E5),
                          disabledForegroundColor: Colors.black45,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                            vertical: width * 0.04,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Text(
                          _currentQuestionIndex.value ==
                                  _questions.length - 1
                              ? 'Selesai'
                              : 'Berikutnya',
                          style: TextStyle(
                            fontSize: bodyFontSize,
                            fontWeight: FontWeight.w600,
                          ),
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
}
