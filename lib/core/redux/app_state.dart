class AppState {
  List<dynamic>? courses = [];

  AppState({
    this.courses,
  });

  AppState.fromAppState(AppState another) {
    courses = another.courses;
  }
}
