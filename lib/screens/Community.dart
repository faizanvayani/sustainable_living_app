import 'package:flutter/material.dart';
import 'package:sustainable_living_app/main.dart';
import 'package:sustainable_living_app/screens/About.dart';
import 'package:sustainable_living_app/screens/Community.dart';
import 'package:sustainable_living_app/screens/tracker.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community Forum')),
      body: Center(
        child: Text(
          'Welcome to the Community Forum! Here you can share your sustainable living tips, ask questions, and connect with like-minded individuals.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
