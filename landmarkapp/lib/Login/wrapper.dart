// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:landmarkapp/Home/home_page.dart';
import 'package:landmarkapp/Login/login_screen.dart';

class NavigateBasedOnAuthStatus extends StatefulWidget {
  const NavigateBasedOnAuthStatus({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigateBasedOnAuthStatusState createState() =>
      _NavigateBasedOnAuthStatusState();
}

class _NavigateBasedOnAuthStatusState extends State<NavigateBasedOnAuthStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginPage();
          }
        },
      ), // StreamBuilder
    ); // Scaffold
  }
}
