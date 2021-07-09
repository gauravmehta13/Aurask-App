import 'app_state.dart';
import 'index.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is Courses) {
    newState.courses = action.payload;
  }

  return newState;
}
