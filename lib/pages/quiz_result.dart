import 'package:flutter/material.dart';
class QuizResultPage extends StatefulWidget {
  final int quizLength;
  final int correctAnswers;
  final double percentage;
  final int quizpoint;

  QuizResultPage(
      {required this.quizLength,
      required this.correctAnswers,
      required this.percentage,
      required this.quizpoint});

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<ContentItem> contentItems = [
    ContentItem(
      icon: Icons.refresh,
      label: 'Play again',
      color: Colors.blue,
    ),
    ContentItem(
      icon: Icons.remove_red_eye,
      label: 'Review answer',
      color: Colors.orange,
    ),
    ContentItem(
      icon: Icons.share,
      label: 'Share score',
      color: Colors.purple,
    ),
    ContentItem(
      icon: Icons.picture_as_pdf,
      label: 'Generate PDF',
      color: Colors.indigo,
    ),
    ContentItem(
      icon: Icons.home,
      label: 'Home',
      color: Colors.lime,
    ),
    ContentItem(
      icon: Icons.leaderboard,
      label: 'Leaderboard',
      color: Colors.teal,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.percentage,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String getGreetingMessage() {
    if (widget.percentage >= 50.0) {
      return 'Congratulations! You passed the quiz.';
    } else {
      return 'Better luck next time!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
        backgroundColor: Colors.white,
        body: Stack(children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color: const Color(0xFF9B52D4),
            ),
          ),
          CustomPaint(
            painter: CirclePainter(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                        padding: const EdgeInsets.only(top: 125),
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return SizedBox(
                                width: 150,
                                height: 150,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: CustomPaint(
                                    painter: CircleProgressBarPainter(
                                      progress: _animation.value,
                                      color: Colors.green,
                                      backgroundColor: Colors.red,
                                      strokeWidth: 10,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Your Score",
                                            style: TextStyle(
                                              color: Colors.purple,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${widget.quizpoint.toInt()}',
                                                  style: const TextStyle(
                                                    fontSize: 30.0,
                                                    color: Colors.purple,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const TextSpan(
                                                  text: 'pt',
                                                  style: TextStyle(
                                                    color: Colors.purple,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            );
                          },
                        )),
                  ),
                ],
              )),
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                        child: Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        heightFactor: 0.6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.only(left: 50.0, top: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${widget.percentage.toInt()}%',
                                            style: const TextStyle(
                                                color: Colors.purple,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                          const Text(
                                            'Completion',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            '${widget.quizLength}',
                                            style: const TextStyle(
                                                color: Colors.purple,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                          const Text(
                                            'Total Question',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            '${widget.correctAnswers}',
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                          const Text(
                                            'Correct',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            '${widget.quizLength - widget.correctAnswers}',
                                            style: const TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                          const Text(
                                            'Wrong',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: GridView.count(
                        crossAxisCount: 3,
                        padding: const EdgeInsets.only(left: 26, right: 26),
                        childAspectRatio: 1.2,
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0,
                        children: contentItems.map((item) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: item.color,
                                child: Icon(
                                  item.icon,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                item.label,
                                style: const TextStyle(
                                    fontSize: 14.0, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ])
    );
  }
}

class CircleProgressBarPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  CircleProgressBarPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const circle4Radius = 90.0;
    final circle4Paint = Paint()
      ..color = const Color.fromARGB(255, 220, 174, 255);
    canvas.drawCircle(center, circle4Radius, circle4Paint);
    const circle1Radius = 75.0;
    final circle1Paint = Paint()..color = Colors.white;
    canvas.drawCircle(center, circle1Radius, circle1Paint);


    final radius = (size.width - strokeWidth) / 2;
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);
    const startAngle = -90.0 * (3.14 / 180);
    final sweepAngle = 360.0 * (progress / 100) * (3.14 / 180);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircleProgressBarPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        color != oldDelegate.color ||
        backgroundColor != oldDelegate.backgroundColor ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}

class ContentItem {
  final IconData icon;
  final String label;
  final Color color;

  ContentItem({required this.icon, required this.label, required this.color});
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const circle1 = Offset(-20, 140);
    const circle1Radius = 80.0;
    final circle1Paint = Paint()
      ..color = const Color.fromARGB(255, 220, 174, 255);

    const circle2 = Offset(190, 0);
    const circle2Radius = 70.0;
    final circle2Paint = Paint()
      ..color = const Color.fromARGB(255, 220, 174, 255);

    const circle3 = Offset(420, 200);
    const circle3Radius = 80.0;
    final circle3Paint = Paint()
      ..color = const Color.fromARGB(255, 220, 174, 255);
    canvas.drawCircle(circle1, circle1Radius, circle1Paint);
    canvas.drawCircle(circle2, circle2Radius, circle2Paint);
    canvas.drawCircle(circle3, circle3Radius, circle3Paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
