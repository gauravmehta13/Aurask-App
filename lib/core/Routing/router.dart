import 'package:aurask/app/Screens/Home/BottomNavBar.dart';
import 'package:aurask/app/Screens/Other/Misc/Terms%20And%20Conditions.dart';
import 'package:aurask/app/Screens/Purchase/Booking%20Complete.dart';
import 'package:aurask/app/auth/Onboarding.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [];
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => BottomNavBar()),
    ChildRoute('/tnc', child: (_, args) => TermsAndConditions()),
    ChildRoute('/invite/:id',
        child: (_, args) => Onboarding(
              id: args.data,
            )),
    ChildRoute('/welcome', child: (_, args) => Onboarding()),
    ChildRoute('/success',
        child: (_, args) => BookingComplete(
              type: args.data,
            )),
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
