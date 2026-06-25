// import 'About.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Modules ki list aapki requirement ke mutabiq
    final List<Map<String, dynamic>> modules = [
      {'title': 'Carbon Tracker', 'icon': Icons.co2, 'color': Colors.green},
      {
        'title': 'Eco Products',
        'icon': Icons.shopping_bag,
        'color': Colors.lightGreen,
      },
      {
        'title': 'Challenges',
        'icon': Icons.emoji_events,
        'color': Colors.orange,
      },
      {'title': 'Green Labels', 'icon': Icons.verified, 'color': Colors.teal},
      {
        'title': 'Waste Reduction',
        'icon': Icons.recycling,
        'color': Colors.blueGrey,
      },
      {'title': 'Recipes', 'icon': Icons.restaurant, 'color': Colors.amber},
      {
        'title': 'Energy Tips',
        'icon': Icons.lightbulb,
        'color': Colors.yellow[800],
      },
      {
        'title': 'Eco Travel',
        'icon': Icons.travel_explore,
        'color': Colors.cyan,
      },
      {'title': 'Gallery', 'icon': Icons.collections, 'color': Colors.purple},
      {
        'title': 'Contact Us',
        'icon': Icons.contact_mail,
        'color': Colors.redAccent,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sustainable Guide',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[100],
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ), // Search Requirement #3
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Welcome Header
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                color: Colors.green[50],
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assalam-o-Alaikum!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Let\'s make the Earth greener today.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),

              // Grid for Modules
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView.builder(
                  shrinkWrap: true, // Scroll handle karne ke liye
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Ek line mein 2 buttons
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: modules.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Yahan click par navigation hogi
                        print("${modules[index]['title']} clicked");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              modules[index]['icon'],
                              size: 40,
                              color: modules[index]['color'],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              modules[index]['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
