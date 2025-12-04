class Exercise {
  Exercise({
    required this.name,
    required this.score,
    required this.submittedAt,
  });
  final String name;
  final int score;
  final DateTime submittedAt;

  bool get isPassed => score >= 60;
}

List<Exercise> passedOnly(List<Exercise> exercises) {
  List<Exercise> passedExercises = [];

  for (var i = 0; i < exercises.length; i++) {
    if (exercises[i].score >= 60) {
      passedExercises[i] = exercises[i];
    }
  }

  return passedExercises;
}

int averageScore(List<Exercise> exercises) {
  int sum = 0;
  for (var i = 0; i < exercises.length; i++) {
    sum = sum + exercises[i].score;
  }
  int avgScore = (sum / exercises.length) as int;
  return avgScore;
}

String bestStudent(List<Exercise> exercises) {
  var max = exercises[0];
  for (var i = 0; i < exercises.length; i++) {
    if (max.score < exercises[i].score) {
      max = exercises[i];
    }
  }

  return max.name;
}
