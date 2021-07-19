class AppState {
  List<dynamic> courses = [];
  List<dynamic> seminars = [];
  List<dynamic>? coupons = [];

  AppState({required this.courses, required this.seminars, this.coupons});

  AppState.fromAppState(AppState another) {
    courses = another.courses;
    seminars = another.seminars;
    coupons = another.coupons;
  }
}
