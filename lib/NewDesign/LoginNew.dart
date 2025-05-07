import 'package:flutter/material.dart';

class LoginNew extends StatefulWidget {
  const LoginNew({Key? key}) : super(key: key);

  @override
  _LoginNewState createState() => _LoginNewState();
}

class _LoginNewState extends State<LoginNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Login")
        ],
      ),
    );
  }
}
