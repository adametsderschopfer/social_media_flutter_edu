import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_flutter_edu/models/comment_model.dart';
import 'package:social_media_flutter_edu/models/post_model.dart';
import 'package:social_media_flutter_edu/widgets/comment_list_tile.dart';

class CommentsScreen extends StatefulWidget {
  static const id = 'commentsScreen';

  const CommentsScreen({super.key});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  String _message = '';

  late TextEditingController _messageTEC;

  @override
  void initState() {
    super.initState();

    _messageTEC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _messageTEC.dispose();
  }

  Future<void> _submit(PostModel post, String message) async {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(post.id)
        .collection("comments")
        .add({
      "userId": FirebaseAuth.instance.currentUser?.uid,
      "userName": FirebaseAuth.instance.currentUser?.displayName,
      "message": message.trim(),
      "timestamp": Timestamp.now(),
    });

    _messageTEC.clear();

    setState(() {
      _message = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final PostModel? currentPost =
        ModalRoute.of(context)!.settings.arguments as PostModel?;

    return Scaffold(
        appBar: AppBar(title: const Text("Comments")),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("posts")
                        .doc(currentPost?.id)
                        .collection("comments")
                        .orderBy('timestamp')
                        .snapshots(),
                    builder: (context, snapshot) {
                      dynamic commentsList = snapshot.data!.docs;

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.connectionState == ConnectionState.none) {
                        return const CircularProgressIndicator();
                      }

                      return ListView.builder(
                          itemCount: commentsList.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final QueryDocumentSnapshot rawComment =
                                commentsList[index];
                            CommentModel comment = CommentModel(
                                userId: rawComment["userId"],
                                message: rawComment['message'],
                                userName: rawComment['userName'],
                                timestamp: rawComment['timestamp']);

                            bool isCurrentUserOwner = comment.userId ==
                                FirebaseAuth.instance.currentUser?.uid;

                            return Align(
                                alignment: isCurrentUserOwner
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: CommentListTile(
                                    commentModel: comment,
                                    isCurrentUserOwner: isCurrentUserOwner));
                          });
                    }),
              ),
              SizedBox(
                height: 50,
                child: Row(children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 5),
                      child: TextField(
                        controller: _messageTEC,
                        maxLines: 2,
                        textInputAction: TextInputAction.done,
                        decoration:
                            const InputDecoration(hintText: "Enter message"),
                        onChanged: (String value) {
                          _message = value;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IconButton(
                        onPressed: () {
                          _submit(currentPost!, _message);
                        },
                        icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  )
                ]),
              )
            ],
          ),
        ));
  }
}
