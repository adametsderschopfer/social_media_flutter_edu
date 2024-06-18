import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
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

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextButton(
                child: const Text("Sign Up"),
                onPressed: () {
                  // TODO: - submit form
                },
              ),
              TextButton(
                child: const Text("Sign In instead"),
                onPressed: () {
                  // todo: go to navigation screen
                },
              )
            ],
          ),
        ),
      ),
    )));
  }
}
