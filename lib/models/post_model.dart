import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;

  final String userId;

  final String userName;

  final Timestamp timestamp;

  final String imageUrl;

  final String description;

  PostModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.timestamp,
    required this.imageUrl,
    required this.description,
  });
}
