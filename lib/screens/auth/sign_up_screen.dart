import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_flutter_edu/screens/auth/sign_in_screen.dart';
import 'package:social_media_flutter_edu/screens/post/posts_screen.dart';

import '../../bloc/auth/auth_cubit.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "sign_up_screen";

  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _username = "";
  String _password = "";

  late final FocusNode _usernameFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();

    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      // Invalid
      return;
    }

    _formKey.currentState!.save();
    context
        .read<AuthCubit>()
        .signUp(email: _email, password: _password, username: _username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
      listener: (context, AuthState currentState) {
        if (currentState is AuthSignedUp) {
          Navigator.of(context).pushReplacementNamed(PostsScreen.id);
        }

        if (currentState is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 2),
              content: Text(currentState.message)));
        }
      },
      builder: (BuildContext context, AuthState state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SafeArea(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Text("Social Media App",
                        style: Theme.of(context).textTheme.headlineLarge),
                  ),

                  const SizedBox(height: 15),

                  // email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        labelText: "Enter your email",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_usernameFocusNode);
                    },
                    onSaved: (value) {
                      _email = value!.trim();
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }

                      // todo: add validator for email -> emailValidationPattern

                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  // username
                  TextFormField(
                    focusNode: _usernameFocusNode,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        labelText: "Enter your username",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    onSaved: (value) {
                      _username = value!.trim();
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter your username";
                      }

                      // todo: add validator for username

                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  // password
                  TextFormField(
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Enter your password",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    onFieldSubmitted: (_) {
                      _submit();
                    },
                    onSaved: (value) {
                      _password = value!.trim();
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }

                      if (value.length < 5) {
                        return "Please enter longer password";
                      }

                      // todo: add validator for password

                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  TextButton(
                    child: const Text("Sign Up"),
                    onPressed: () {
                      _submit();
                    },
                  ),
                  TextButton(
                    child: const Text("Sign In instead"),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SignInScreen.id);
                    },
                  )
                ],
              ),
            ),
          ),
        ));
      },
    ));
  }
}
