import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_flutter_edu/screens/sign_in_screen.dart';
import 'package:social_media_flutter_edu/screens/sign_up_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SignUpScreen(),
      routes: {
        SignInScreen.id: (BuildContext context) => const SignInScreen(),
        SignUpScreen.id: (BuildContext context) => SignUpScreen(),
      },
    );
  }
}
