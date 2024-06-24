import 'package:flutter/material.dart';
import 'package:social_media_flutter_edu/models/comment_model.dart';

class CommentListTile extends StatelessWidget {
  const CommentListTile(
      {super.key,
      required this.commentModel,
      required this.isCurrentUserOwner});

  final CommentModel commentModel;
  final bool isCurrentUserOwner;

  @override
  Widget build(BuildContext context) {
    DateTime date = commentModel.timestamp.toDate();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),
              bottomLeft:
                  isCurrentUserOwner ? const Radius.circular(10) : Radius.zero,
              bottomRight:
                  isCurrentUserOwner ? Radius.zero : const Radius.circular(10),
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: isCurrentUserOwner
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: isCurrentUserOwner
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: <Widget>[
              Text(
                commentModel.userName,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                commentModel.message.trim(),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${date.hour}:${date.minute}",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
