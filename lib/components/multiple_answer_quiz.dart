import 'package:flutter/material.dart';

class MultipleCorrectAnswerQuestionWidget extends StatelessWidget {
  final List<dynamic> options;
  final List<dynamic> selectedAnswers;
  final ValueChanged<List<dynamic>> onAnswerSelected;

  const MultipleCorrectAnswerQuestionWidget({
    required this.options,
    required this.selectedAnswers,
    required this.onAnswerSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(options.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selectedAnswers.contains(index)
                  ? Colors.purple
                  : Colors.grey[300]!,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: CheckboxListTile(
            title: Text(
              options[index],
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            value: selectedAnswers.contains(index),
            onChanged: (value) {
              List<dynamic> updatedAnswers = List.from(selectedAnswers);
              if (value == true) {
                updatedAnswers.add(index);
              } else {
                updatedAnswers.remove(index);
              }
              onAnswerSelected(updatedAnswers);
            },
            activeColor: Colors.purple,
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.symmetric(horizontal: 6),
          ),
        );
      }),
    );
  }
}
