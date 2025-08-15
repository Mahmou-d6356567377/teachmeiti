import 'package:go_router/go_router.dart';
import 'package:teachmeiti/presentation/views/add_subject/add_subject.dart';
import 'package:teachmeiti/presentation/views/auth/forget_password/forget_password.dart';
import 'package:teachmeiti/presentation/views/auth/makeaccount/make_account.dart';
import 'package:teachmeiti/presentation/views/auth/signIn/signIn_screen.dart';
import 'package:teachmeiti/presentation/views/auth/user_data_screen/user_data_screen.dart';
import 'package:teachmeiti/presentation/views/home/home.dart';
import 'package:teachmeiti/presentation/views/home/screens/subject_screen.dart';
import 'package:teachmeiti/presentation/views/navBar/nav_bar.dart';

class GoRoutes {
  static const String home = '/home';
  static const String makeaccount = '/makeaccount';
  static const String forgetpassword = '/forgetpassword';
  static const String navbarscreen = '/navbarscreen';
  static const String signInscreen = '/signInscreen';
  static const String addsubjectscreen = '/addsubjectscreen';
  static const String subjectScreen = '/subjectScreen';
  static const String makeacountdetailscreen = '/makeacountdetailscreen';

  static GoRouter getRouter(bool isLoggedIn) {
    return GoRouter(
      initialLocation: isLoggedIn ? navbarscreen : makeaccount,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(path: home, builder: (context, state) => HomeScreen()),
        GoRoute(path: makeaccount, builder: (context, state) => MakeAccount()),
        GoRoute(
          path: forgetpassword,
          builder: (context, state) => ForgetPasswordScreen(),
        ),
        GoRoute(
          path: navbarscreen,
          builder: (context, state) => NavBarScreen(),
        ),
        GoRoute(
          path: signInscreen,
          builder: (context, state) => SignInScreen(),
        ),
        GoRoute(
          path: addsubjectscreen,
          builder: (context, state) => AddSubjectScreen(),
        ),
        GoRoute(
          path: subjectScreen,
          builder: (context, state) {
            final extras = state.extra as Map<String, String>;
            return SubjectScreen(
              subjectId: extras['subjectId'] ?? '',
              subjectName: extras['subjectName'] ?? '',
            );
          },
        ),
        GoRoute(
          path: makeacountdetailscreen,
          builder: (context, state) => MakeAccountDetailsScreen(uid: state.extra as String),
        ),
        
      ],
    );
  }
}
