import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String userId;

  final String userName;

  final String message;

  final Timestamp timestamp;

  CommentModel({
    required this.userId,
    required this.message,
    required this.userName,
    required this.timestamp,
  });
}
