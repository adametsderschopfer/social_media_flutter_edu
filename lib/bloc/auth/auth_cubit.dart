import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    emit(const AuthLoading());

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      emit(const AuthSignedIn());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(
          message: 'An error has occurred.'
              '\nError code: ${e.code}.'
              '\nMessage: ${e.message}'));
    }
  }

  Future<void> signUp({
    required String email,
    required String username,
    required String password,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    FirebaseAuth auth = FirebaseAuth.instance;

    emit(const AuthLoading());
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await users.doc(userCredential.user!.uid).set({
        'userId': userCredential.user!.uid,
        'username': username,
        'email': email,
      });

      emit(const AuthSignedUp());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(
          message: 'An error has occurred.'
              '\nError code: ${e.code}.'
              '\nMessage: ${e.message}'));
    }
  }
}
