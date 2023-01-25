import 'package:chat_app/app_bloc_observer.dart';
import 'package:chat_app/app_route.dart';
import 'package:chat_app/core/services/service_locator.dart';
import 'package:chat_app/features/chats/presentation/pages/dashboard_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/presentation/pages/login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  ServiceLocator.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (ctx, snap) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.purple,
          ),
          onGenerateRoute: AppRoute.generateRoute,
          initialRoute:
              snap.data == null ? LoginPage.route : DashBoardPage.route),
    );
  }
}
