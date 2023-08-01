import 'package:flutter/material.dart';
import 'package:quizzy/api_caller/quiz.dart';
import 'package:quizzy/models/quiz_model.dart';
import 'package:quizzy/pages/practice_questions.dart';
import 'package:quizzy/pages/quiz_page.dart';

class QuizDetails extends StatefulWidget {
  final QuizData quiz;
  const QuizDetails({Key? key, required this.quiz}) : super(key: key);

  @override
  State<QuizDetails> createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  QuizApi quizApi = QuizApi();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double passageHeight = screenHeight * 0.37;
    int quizLength = widget.quiz.questions.length;
    var len = quizLength.toString();
    var title = widget.quiz.title;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.question_answer,
                                color: Colors.deepPurple),
                            const SizedBox(width: 8),
                            Text(
                              "$len Questions",
                              style: const TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey[300],
                      ),
                      const Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.star, color: Colors.orange),
                            SizedBox(width: 8),
                            Text(
                              '100 Points',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: passageHeight,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const SingleChildScrollView(
                    child: Text(
                      "বিজ্ঞানের যে শাখায় পদার্থ এবং শক্তির মিথস্ক্রিয়া নিয়ে আলোচনা করা হয় তাকে পদার্থবিজ্ঞান বলে।পদার্থবিজ্ঞান একটি প্রাকৃতিক বিজ্ঞান যা শক্তি এবং বলের মতো ধারণার পাশাপাশি স্থান ও কাল সাপেক্ষে পদার্থের গতি নিয়ে আলোচনা করে থাকে। সংক্ষেপে বললে, মহাবিশ্ব কীভাবে আচরণ করে তা বোঝার প্রয়াসে এটি একটি প্রাকৃতিক অধ্যয়ন।পদার্থবিজ্ঞান  শক্তি এবং পদার্থ সম্পর্কিত মৌলিক নীতিগুলি উদঘাটন করতে এবং এই নীতিগুলোর প্রভাব আবিষ্কার করতে বৈজ্ঞানিক পদ্ধতি ব্যবহার করে। এটি ধরে নেওয়া হয় যে এমন কিছু নিয়ম রয়েছে যার দ্বারা মহাবিশ্ব পরিচালিত হয় এবং সেই নিয়মগুলোর খুব সামান্য অংশ মানুষ বুঝতে পারে। ",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                      radius: 24,
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Creator Name',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Creator',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PracticeQuestionPage(quiz: widget.quiz)));
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Prepare Yourself",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizPage(quiz: widget.quiz)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Attempt Quiz',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
