import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_flutter_edu/bloc/auth/auth_cubit.dart';
import 'package:social_media_flutter_edu/screens/auth/sign_in_screen.dart';
import 'package:social_media_flutter_edu/screens/auth/sign_up_screen.dart';
import 'package:social_media_flutter_edu/screens/post/comments/comments_screen.dart';
import 'package:social_media_flutter_edu/screens/post/create_post_screen.dart';
import 'package:social_media_flutter_edu/screens/post/posts_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget _buildHomeScreen() {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const PostsScreen();
          }

          return const SignInScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) {
        return AuthCubit();
      },
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: _buildHomeScreen(),
        routes: {
          SignInScreen.id: (BuildContext context) => const SignInScreen(),
          SignUpScreen.id: (BuildContext context) => const SignUpScreen(),
          PostsScreen.id: (BuildContext context) => const PostsScreen(),
          CreatePostScreen.id: (BuildContext context) =>
              const CreatePostScreen(),
          CommentsScreen.id: (BuildContext context) => const CommentsScreen(),
        },
      ),
    );
  }
}
