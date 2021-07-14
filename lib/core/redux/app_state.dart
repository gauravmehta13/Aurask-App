class AppState {
  List<dynamic> courses = [];
  List<dynamic> seminars = [];

  AppState({required this.courses, required this.seminars});

  AppState.fromAppState(AppState another) {
    courses = another.courses;
    seminars = another.seminars;
  }
}
