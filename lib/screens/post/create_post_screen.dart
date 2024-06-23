import 'dart:io';

import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  static String id = 'createPostScreen';

  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final imageFile = arguments['imageFile'] as File;

    return const Center(
      child: Text("Create Post Screen"),
    );
  }
}
