import 'package:flutter/material.dart';

class SingleCorrectAnswerWidget extends StatelessWidget {
  final int questionIndex;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final int selectedAnswer;

  const SingleCorrectAnswerWidget({
    Key? key,
    required this.questionIndex,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.selectedAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCorrect = selectedAnswer == correctAnswer;
    final isSkiped = selectedAnswer == options.length;
    final optionColor =
        isCorrect ? Colors.green : (selectedAnswer != -1 ? Colors.red : null);
    final iconData = isCorrect ? Icons.check : Icons.close;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question $questionIndex',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                isSkiped ? 'Skipped' : (isCorrect ? 'Correct' : 'Incorrect'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSkiped
                      ? Colors.purple
                      : (isCorrect ? Colors.green : Colors.red),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            question,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: List.generate(options.length, (optionIndex) {
              final option = options[optionIndex];
              final isSelected = selectedAnswer == optionIndex;
              final isCorrectedOption =
                  !isCorrect && correctAnswer == optionIndex;

              return InkWell(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? optionColor : null,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isCorrectedOption
                          ? Colors.green[300]!
                          : optionColor ?? Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isCorrectedOption
                            ? Icons.check
                            : isSelected
                                ? iconData
                                : null,
                        color: isCorrectedOption ? Colors.green : Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected ? Colors.white : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
