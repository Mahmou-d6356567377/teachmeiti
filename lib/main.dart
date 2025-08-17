import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teachmeiti/firebase_options.dart';
import 'package:teachmeiti/models/tasks/task_model.dart';
import 'package:teachmeiti/presentation/providers/bloc_providers.dart';
import 'package:teachmeiti/utils/consts/const_text.dart';
import 'package:teachmeiti/utils/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());

  await Hive.openBox(ConstText.hivebox1);
  await Hive.deleteBoxFromDisk(ConstText.hivebox2);
  await Hive.openBox<TaskModel>(ConstText.hivebox2);

  // SharedPrefs check
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool(ConstText.sharedprefIsLogin) ?? false;
  final String uid = prefs.getString(ConstText.sharedprefIDU) ?? '';

  runApp(MainApp(isLoggedIn: isLoggedIn, uid: uid));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  final String uid;
  const MainApp({super.key, required this.isLoggedIn, required this.uid});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBlocProviders.allBlocProviders,
      child: MaterialApp.router(
        routerConfig: GoRoutes.getRouter(isLoggedIn, uid),
      ),
    );
  }
}
