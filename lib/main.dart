import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_wan_app/cubit/auth_cubit.dart';
import 'package:task_wan_app/cubit/cubit/sign_up_cubit.dart';
import 'package:task_wan_app/firebase_options.dart';
import 'package:task_wan_app/router/app_router.dart';
import 'package:task_wan_app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => SignUpCubit()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Wan',
      theme: AppTheme.theme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? '/home'
          : '/sign_up',
    );
  }
}
