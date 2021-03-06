import 'package:aurask/app/Screens/Quiz/home.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../app/Screens/Home/BottomNavBar.dart';
import '../../app/Screens/Info%20Screens/CourseInfo.dart';
import '../../app/Screens/Info%20Screens/SeminarInfo.dart';
import '../../app/Screens/Other/Misc/Terms%20And%20Conditions.dart';
import '../../app/Screens/Other/SearchCourses.dart';
import '../../app/Screens/Purchase/Booking%20Complete.dart';
import '../../app/auth/Onboarding.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => BottomNavBar()),
    ChildRoute('/tnc', child: (_, args) => TermsAndConditions()),
    ChildRoute(
      '/course',
      child: (_, args) => CourseInfo(course: args.data),
    ),
    ChildRoute(
      '/liveSession',
      child: (_, args) => SeminarInfo(
        seminar: args.data,
      ),
    ),
    ChildRoute(
      '/liveSession/:id',
      child: (_, args) => SeminarInfo(
        id: args.params['id'],
      ),
    ),
    ChildRoute(
      '/course/:id',
      child: (_, args) => CourseInfo(
        id: args.params['id'],
      ),
    ),
    ChildRoute('/invite/:id',
        child: (_, args) => Onboarding(
              id: args.params['id'],
            )),
    ChildRoute('/welcome', child: (_, args) => Onboarding()),
    ChildRoute('/success',
        child: (_, args) => BookingComplete(
              data: args.data,
            )),
    ChildRoute(
      '/search',
      child: (_, args) => SearchCourses(),
    ),
    ChildRoute(
      '/search/:keyword',
      child: (_, args) => SearchCourses(
        keyword: args.params['keyword'],
      ),
    ),
    ChildRoute('/playAndWin', child: (_, args) => QuizHome()),
  ];
}

// class AuthGuard implements RouteGuard {
//   @override
//   Future<bool> canActivate(String url, ModularRoute route) async {
//     if (url == '/login') {
//       if (_auth.currentUser == null) {
//         return true;
//       } else
//         return false;
//     } else {
//       return false;
//     }
//   }

//   @override
//   // TODO: implement guardedRoute
//   String get guardedRoute => throw UnimplementedError();
// }
