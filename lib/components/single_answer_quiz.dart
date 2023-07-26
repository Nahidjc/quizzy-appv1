import 'package:flutter/material.dart';

class SingleCorrectAnswerQuestionWidget extends StatelessWidget {
  final List<dynamic> options;
  final dynamic selectedAnswer;
  final ValueChanged<dynamic> onAnswerSelected;

  const SingleCorrectAnswerQuestionWidget({
    Key? key,
    required this.options,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.center,
      widthFactor: 1,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(options.length, (index) {
            return InkWell(
              onTap: () {
                onAnswerSelected(index);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedAnswer == index
                        ? Colors.purple
                        : Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Radio(
                      value: index,
                      groupValue: selectedAnswer,
                      onChanged: (value) {
                        onAnswerSelected(value);
                      },
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        options[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedAnswer == index
                              ? Colors.purple
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
