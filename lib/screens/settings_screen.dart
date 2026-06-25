import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _emailUpdates = false;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: ListView(
        children: [
          _buildSection('Account'),
          _buildTile(
            Icons.person,
            'Profile',
            'Manage your profile',
            () {},
          ),
          _buildTile(
            Icons.email,
            'Email',
            user?.email ?? '',
            null,
          ),
          const Divider(),
          _buildSection('Preferences'),
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive updates and reminders'),
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
            secondary: const Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: const Text('Email Updates'),
            subtitle: const Text('Weekly sustainability tips'),
            value: _emailUpdates,
            onChanged: (v) => setState(() => _emailUpdates = v),
            secondary: const Icon(Icons.mail),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Coming soon'),
            value: _darkMode,
            onChanged: null,
            secondary: const Icon(Icons.dark_mode),
          ),
          const Divider(),
          _buildSection('App'),
          _buildTile(Icons.info, 'Version', '1.0.0', null),
          _buildTile(Icons.privacy_tip, 'Privacy Policy', '', () {}),
          _buildTile(Icons.description, 'Terms of Service', '', () {}),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, String subtitle, VoidCallback? onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
      onTap: onTap,
    );
  }
}
