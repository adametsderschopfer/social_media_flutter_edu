import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_flutter_edu/bloc/auth/auth_cubit.dart';
import 'package:social_media_flutter_edu/screens/auth/sign_in_screen.dart';
import 'package:social_media_flutter_edu/screens/post/create_post_screen.dart';

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
          IconButton(
              onPressed: () {
                final imagePicker = ImagePicker();
                imagePicker
                    .pickImage(source: ImageSource.gallery, imageQuality: 50)
                    .then((xFile) {
                  if (xFile != null) {
                    final file = File(xFile.path);

                    Navigator.of(context).pushNamed(
                      CreatePostScreen.id,

                      /*
                      * Notice!
                      *   We can use only file like arguments: file,
                      *   and then get it from arguments in ModalRoute without map
                      *
                      *   I do it only for can show for me how can i use map params
                      *   in navigator
                      * */
                      arguments: {
                        'imageFile': file,
                      },
                    );
                  }
                });
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () async {
                await context.read<AuthCubit>().signOut();
                Navigator.of(context).pushReplacementNamed(SignInScreen.id);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(itemBuilder: (_, index) {
        return const Text("Body Here");
      }),
    );
  }
}
