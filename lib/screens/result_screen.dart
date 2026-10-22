
import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double padding = width * 0.06;

    final double bodyFontSize =
        (width * 0.038).clamp(13.0, 16.0);

    final double headingFontSize =
        (width * 0.07).clamp(25.0, 34.0);

    final int wrongAnswers = totalQuestions - score;

    final double percentage = totalQuestions == 0
        ? 0
        : score / totalQuestions * 100;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Hasil Kuis',
          style: TextStyle(
            fontSize: bodyFontSize * 1.15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: width * 0.06),

              Text(
                'Kuis selesai',
                style: TextStyle(
                  fontSize: headingFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: width * 0.02),

              Text(
                'Berikut adalah hasil pengerjaan kamu.',
                style: TextStyle(
                  fontSize: bodyFontSize,
                  color: Colors.black54,
                ),
              ),

              SizedBox(height: width * 0.10),

              const Divider(
                color: Color(0xFFE0E0E0),
              ),

              SizedBox(height: width * 0.06),

              Text(
                'SKOR AKHIR',
                style: TextStyle(
                  fontSize: bodyFontSize * 0.85,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),

              SizedBox(height: width * 0.02),

              Text(
                '$score dari $totalQuestions',
                style: TextStyle(
                  fontSize: (width * 0.09).clamp(32.0, 44.0),
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: width * 0.015),

              Text(
                '${percentage.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: bodyFontSize,
                  color: Colors.black54,
                ),
              ),

              SizedBox(height: width * 0.07),

              const Divider(
                color: Color(0xFFE0E0E0),
              ),

              _buildResultRow(
                'Jawaban benar',
                score.toString(),
                bodyFontSize,
                width,
              ),

              _buildResultRow(
                'Jawaban salah',
                wrongAnswers.toString(),
                bodyFontSize,
                width,
              ),

              _buildResultRow(
                'Jumlah pertanyaan',
                totalQuestions.toString(),
                bodyFontSize,
                width,
              ),

              SizedBox(height: width * 0.06),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const QuizScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      vertical: width * 0.04,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Ulangi Kuis',
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
      ),
    );
  }

  Widget _buildResultRow(
    String label,
    String value,
    double fontSize,
    double width,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: width * 0.04,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
