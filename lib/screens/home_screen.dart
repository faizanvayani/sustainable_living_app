import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'carbon_footprint_screen.dart';
import 'eco_products_screen.dart';
import 'challenges_screen.dart';
import 'recipes_screen.dart';
import 'energy_tips_screen.dart';
import 'waste_tracker_screen.dart';
import 'certifications_screen.dart';
import 'community_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _HomeTab(),
    const CarbonFootprintScreen(),
    const ChallengesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF4CAF50),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.eco), label: 'Track'),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events), label: 'Challenges'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;

    final features = [
      {
        'title': 'Carbon Footprint',
        'icon': Icons.eco,
        'color': const Color(0xFFD7F0D7),
        'iconColor': const Color(0xFF4CAF50),
        'screen': const CarbonFootprintScreen(),
      },
      {
        'title': 'Eco Products',
        'icon': Icons.shopping_bag,
        'color': const Color(0xFFD0E8FF),
        'iconColor': const Color(0xFF2196F3),
        'screen': const EcoProductsScreen(),
      },
      {
        'title': 'Challenges',
        'icon': Icons.emoji_events,
        'color': const Color(0xFFFFF3D0),
        'iconColor': const Color(0xFFFF9800),
        'screen': const ChallengesScreen(),
      },
      {
        'title': 'Recipes',
        'icon': Icons.restaurant,
        'color': const Color(0xFFF3D0FF),
        'iconColor': const Color(0xFF9C27B0),
        'screen': const RecipesScreen(),
      },
      {
        'title': 'Energy Tips',
        'icon': Icons.lightbulb,
        'color': const Color(0xFFFFF9D0),
        'iconColor': const Color(0xFFFFC107),
        'screen': const EnergyTipsScreen(),
      },
      {
        'title': 'Waste Tracker',
        'icon': Icons.delete_outline,
        'color': const Color(0xFFFFD0D0),
        'iconColor': const Color(0xFFF44336),
        'screen': const WasteTrackerScreen(),
      },
      {
        'title': 'Certifications',
        'icon': Icons.verified,
        'color': const Color(0xFFD0F5F0),
        'iconColor': const Color(0xFF009688),
        'screen': const CertificationsScreen(),
      },
      {
        'title': 'Community',
        'icon': Icons.people,
        'color': const Color(0xFFDDD0FF),
        'iconColor': const Color(0xFF673AB7),
        'screen': const CommunityScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sustainable Living'),
        backgroundColor: const Color(0xFF4CAF50),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person,
                        size: 36, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome back,',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                      Text(
                        user?.username ?? 'User',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: Text(
                'Explore Features',
                style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // Feature Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                itemCount: features.length,
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return _FeatureCard(
                    title: feature['title'] as String,
                    icon: feature['icon'] as IconData,
                    bgColor: feature['color'] as Color,
                    iconColor: feature['iconColor'] as Color,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => feature['screen'] as Widget),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
