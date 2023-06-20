class QuizPoints {
  int calculatePoints(int correctAnswers, int remainingTime, int quizLength) {
    int basePoints = correctAnswers * 10;
    double percentage = correctAnswers / quizLength;
    int timeBonus;
    if (percentage == 1.0) {
      timeBonus = remainingTime;
    } else if (percentage >= 0.9) {
      timeBonus = (remainingTime * 0.9).round();
    } else if (percentage >= 0.8) {
      timeBonus = (remainingTime * 0.8).round();
    } else if (percentage >= 0.7) {
      timeBonus = (remainingTime * 0.7).round();
    } else if (percentage >= 0.6) {
      timeBonus = (remainingTime * 0.6).round();
    } else if (percentage >= 0.5) {
      timeBonus = (remainingTime * 0.5).round();
    } else if (percentage >= 0.4) {
      timeBonus = (remainingTime * 0.4).round();
    } else if (percentage >= 0.3) {
      timeBonus = (remainingTime * 0.3).round();
    } else if (percentage >= 0.2) {
      timeBonus = (remainingTime * 0.2).round();
    } else if (percentage >= 0.1) {
      timeBonus = (remainingTime * 0.1).round();
    } else {
      timeBonus = 0;
    }

    int totalPoints = basePoints + timeBonus;

    return totalPoints;
  }
}
