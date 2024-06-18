import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _username = "";
  String _password = "";

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text("Social Media App",
              style: Theme.of(context).textTheme.headlineLarge),

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

          // password
          TextFormField(
            focusNode: _passwordFocusNode,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: "Enter your password",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
            onFieldSubmitted: (_) {
              // TODO: - submit form
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

          TextButton(
            child: const Text("Sign Up"),
            onPressed: () {
              // TODO: - submit form
            },
          )
        ],
      ),
    )));
  }
}
