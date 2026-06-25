import 'package:flutter/material.dart';
// import 'package:sustainable_living_app/screens/About.dart';
// import 'package:sustainable_living_app/screens/Community.dart';
// import 'package:sustainable_living_app/screens/tracker.dart';
// import 'package:sustainable_living_app/screens/Home.dart';

class Tracker extends StatelessWidget {
  const Tracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sustainability Tracker')),
      body: Center(
        child: Text(
          'Track your sustainable living habits here! Log your daily actions, set goals, and see your progress over time.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
