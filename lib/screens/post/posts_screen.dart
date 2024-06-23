import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
        backgroundColor: Colors.black26,
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
      body: StreamBuilder<QuerySnapshot>(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong on data loading..."),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          dynamic docsList = snapshot.data!.docs;

          return ListView.builder(
              itemCount: docsList.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(docsList[index]['imageUrl'])),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(docsList[index]['userName'],
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 5),
                      Text(docsList[index]['description'],
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                );
              });
        },
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      ),
    );
  }
}
