import 'package:flutter/material.dart';

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
        ],
      ),
      body: const Text("Body Here"),
    );
  }
}
