import 'dart:developer';

import 'package:firebase_chat_app/consts.dart';
import 'package:firebase_chat_app/services/auth_service.dart';
import 'package:firebase_chat_app/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;
  String? email, password;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: [
          _headerText(),
          _loginForm(),
          _createAccountLink(),
        ],
      ),
    ));
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, Welcome Back!",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
          ),
          Text(
            "Hello again you have been missed!",
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.40,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.05,
      ),
      child: Form(
        autovalidateMode: autovalidateMode!,
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomFormField(
              onSaved: (val) {
                setState(() {
                  email = val;
                });
              },
              validationRegex: EMAIL_VALIDATION_REGEX,
              hintText: "Email",
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
            CustomFormField(
              onSaved: (val) {
                setState(() {
                  password = val;
                });
              },
              obsecureText: true,
              validationRegex: PASSWORD_VALIDATION_REGEX,
              height: MediaQuery.sizeOf(context).height * 0.1,
              hintText: "Password",
            ),
            _loginButton()
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.08,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
        ),
        onPressed: () async {
          if (_loginFormKey.currentState!.validate()) {
            _loginFormKey.currentState!.save();
            bool result = await _authService.login(email!, password!);
            log(result.toString());
            if (result) {}
          } else {
            setState(() {
              autovalidateMode = AutovalidateMode.always;
            });
          }
        },
        child: const Text("Login"),
      ),
    );
  }

  Widget _createAccountLink() {
    return const Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account? "),
          Text(
            "Sign up",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
