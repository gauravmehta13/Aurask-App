class AppState {
  List<dynamic> courses = [];

  AppState({
    required this.courses,
  });

  AppState.fromAppState(AppState another) {
    courses = another.courses;
  }
}
