import 'package:flutter/material.dart';
// import 'package:sustainable_living_app/screens/About.dart';
// import 'package:sustainable_living_app/screens/Community.dart';
// import 'package:sustainable_living_app/screens/tracker.dart';
// import 'package:sustainable_living_app/screens/Home.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sustainable Living Guide',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Our mission is to empower individuals to live more sustainably by providing practical tips, resources, and a supportive community.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Email: sustainableliving@example.com',
              style: TextStyle(fontSize: 16),
            ),
            Text('Phone: +1 234 567 890', style: TextStyle(fontSize: 16)),
            Text(
              'Address: 123 Green Street, Eco City, Earth',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
