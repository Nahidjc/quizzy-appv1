import 'package:flutter/material.dart';

class MultipleCorrectAnswerWidget extends StatelessWidget {
  final int questionIndex;
  final String question;
  final List<String> options;
  final List<int> correctAnswers;
  final List<int> selectedAnswers;

  const MultipleCorrectAnswerWidget({
    Key? key,
    required this.questionIndex,
    required this.question,
    required this.options,
    required this.correctAnswers,
    required this.selectedAnswers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                _getAnswerStatus(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _getAnswerStatusColor(),
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
              final isSelected = selectedAnswers.contains(optionIndex);
              final isCorrectedOption = _isCorrectAnswer(optionIndex);

              return InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? _getOptionColor(option) : null,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _getOptionBorderColor(option),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getOptionIcon(isCorrectedOption, isSelected),
                        color: _getOptionIconColor(isCorrectedOption),
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

  bool _isCorrectAnswer(int optionIndex) {
    return correctAnswers.contains(optionIndex);
  }

  String _getAnswerStatus() {
    if (correctAnswers.toSet().difference(selectedAnswers.toSet()).isEmpty &&
        selectedAnswers.toSet().difference(correctAnswers.toSet()).isEmpty) {
      return 'Correct';
    } else {
      return 'Incorrect';
    }
  }

  Color _getAnswerStatusColor() {
    if (correctAnswers.toSet().difference(selectedAnswers.toSet()).isEmpty &&
        selectedAnswers.toSet().difference(correctAnswers.toSet()).isEmpty) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  Color? _getOptionColor(option) {
    if (_isCorrectAnswer(options.indexOf(option))) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  Color _getOptionBorderColor(option) {
    return _isCorrectAnswer(options.indexOf(option))
        ? Colors.green[300]!
        : _getOptionColor(option) ?? Colors.grey[300]!;
  }

  IconData? _getOptionIcon(bool isCorrectedOption, bool isSelected) {
    if (isCorrectedOption) {
      return Icons.check;
    } else if (isSelected) {
      return Icons.close;
    } else {
      return null;
    }
  }

  Color? _getOptionIconColor(bool isCorrectedOption) {
    if (isCorrectedOption) {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }
}
