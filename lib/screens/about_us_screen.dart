import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo
            Center(
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.eco,
                  size: 80,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // App Name
            const Center(
              child: Text(
                'Sustainable Living Guide',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Mission Section
            _buildSection(
              'Our Mission',
              'To empower individuals to live sustainably by providing tools, information, and community support to reduce environmental impact and make eco-conscious choices.',
              Icons.flag,
            ),
            const SizedBox(height: 24),

            // Vision Section
            _buildSection(
              'Our Vision',
              'A world where sustainable living is accessible to everyone, and every individual contributes to a healthier planet through informed, eco-friendly lifestyle choices.',
              Icons.visibility,
            ),
            const SizedBox(height: 24),

            // What We Offer
            _buildSection(
              'What We Offer',
              '• Carbon Footprint Tracking\n'
              '• Eco-Friendly Product Recommendations\n'
              '• Sustainability Challenges\n'
              '• Plant-Based Recipes\n'
              '• Energy Conservation Tips\n'
              '• Green Certifications Guide\n'
              '• Community Support',
              Icons.eco,
            ),
            const SizedBox(height: 24),

            // Features
            const Text(
              'Key Features',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildFeatureTile(
              Icons.calculate,
              'Track Impact',
              'Monitor your daily carbon footprint and waste reduction',
            ),
            _buildFeatureTile(
              Icons.shopping_bag,
              'Smart Shopping',
              'Discover eco-friendly products and sustainable alternatives',
            ),
            _buildFeatureTile(
              Icons.emoji_events,
              'Stay Motivated',
              'Join challenges and earn points for sustainable actions',
            ),
            _buildFeatureTile(
              Icons.people,
              'Community',
              'Connect with like-minded individuals on their eco-journey',
            ),
            const SizedBox(height: 32),

            // Team
            const Center(
              child: Text(
                'Developed with ❤️ for the Planet',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                '© 2024 Sustainable Living Guide',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () {
                  // Open privacy policy
                },
                child: const Text('Privacy Policy'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF4CAF50), size: 28),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF4CAF50), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
