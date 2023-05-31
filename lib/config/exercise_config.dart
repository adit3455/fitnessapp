class ExerciseConfig {
  String exerciseTypeChanger(String type) {
    if (type == 'lbworkout') {
      return 'Lower Body Workout';
    }
    if (type == 'ubworkout') {
      return 'Upper Body Workout';
    } else {
      return 'Full Body Workout';
    }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
