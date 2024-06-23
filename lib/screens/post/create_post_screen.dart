import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media_flutter_edu/utilis/constants.dart';

class CreatePostScreen extends StatefulWidget {
  static String id = 'createPostScreen';

  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String _description = "";

  Future<void> _submit({
    required File image,
    required String description,
  }) async {
    FocusScope.of(context).unfocus();

    if (_description.trim().isEmpty) {
      return;
    }

    FirebaseStorage storage = FirebaseStorage.instance;

    late String imageUrl;
    String imageName = 'post_image_${UniqueKey().toString()}.png';
    Reference imageRef = storage.ref("$fcAssetsStoragePath/$imageName");

    try {
      TaskSnapshot taskSnapshot = await imageRef.putFile(image);
      imageUrl = await taskSnapshot.ref.getDownloadURL();

      DocumentReference docRef =
          await FirebaseFirestore.instance.collection('posts').add({
        "timestamp": Timestamp.now(),
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "description": _description,
        "imageUrl": imageUrl,
      });

      docRef.update({"postId": docRef.id});

      Navigator.of(context).pop();
    } catch (error) {
      print(error.toString());
      imageRef.delete();
      // remove image if not write
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final imageFile = arguments['imageFile'] as File;

    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: FileImage(imageFile), fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Enter a description",
                  ),
                  textInputAction: TextInputAction.done,
                  inputFormatters: [LengthLimitingTextInputFormatter(180)],
                  onChanged: (value) {
                    _description = value;
                  },
                  onEditingComplete: () {
                    _submit(image: imageFile, description: _description);
                  },
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () {
                      _submit(image: imageFile, description: _description);
                    },
                    child: const Text('Add'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
