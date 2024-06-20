import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_flutter_edu/bloc/auth/auth_cubit.dart';
import 'package:social_media_flutter_edu/screens/auth/sign_up_screen.dart';

class PostsScreen extends StatefulWidget {
  static const id = "postsScreen";

  const PostsScreen({super.key});

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                context.read<AuthCubit>().signOut();
                Navigator.of(context).pushReplacementNamed(SignUpScreen.id);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Text("Body Here"),
    );
  }
}
