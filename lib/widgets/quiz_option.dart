
import 'package:flutter/material.dart';

class QuizOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final String? feedback;
  final VoidCallback? onTap;

  const QuizOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.feedback,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double fontSize = (width * 0.04).clamp(13.0, 17.0);

    return Container(
      margin: EdgeInsets.only(bottom: width * 0.03),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFF5F5F5)
            : Colors.white,
        border: Border.all(
          color: isSelected
              ? Colors.black
              : const Color(0xFFE0E0E0),
          width: isSelected ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: width * 0.01,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.w400,
            color: Colors.black,
          ),
        ),
        trailing: feedback == null
            ? null
            : Text(
                feedback!,
                style: TextStyle(
                  fontSize: fontSize * 0.85,
                  color: Colors.black54,
                ),
              ),
        onTap: onTap,
      ),
    );
  }
}
