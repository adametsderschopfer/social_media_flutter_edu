import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_flutter_edu/bloc/auth/auth_cubit.dart';
import 'package:social_media_flutter_edu/screens/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  static const String id = "sign_in_screen";

  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();

    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    _passwordFocusNode.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      // Invalid
      return;
    }

    _formKey.currentState!.save();
    context.read<AuthCubit>().signIn(email: _email, password: _password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
      listener: (prevState, currentState) {
        if (currentState is AuthSignedIn) {
          // TODO: navigation to posts
        }

        if (currentState is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 2),
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
                      _submit();
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
                    child: const Text("Sign In"),
                    onPressed: () {
                      _submit();
                    },
                  ),
                  TextButton(
                    child: const Text("Sign Up instead"),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SignUpScreen.id);
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
