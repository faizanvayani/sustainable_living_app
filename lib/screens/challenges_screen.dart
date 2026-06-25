import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database_helper.dart';
import '../models/challenge.dart';
import '../providers/user_provider.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  List<Challenge> _challenges = [];
  bool _isLoading = true;
  Set<int> _joinedChallengeIds = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final challenges = await DatabaseHelper.instance.getAllChallenges();
    final user =
        Provider.of<UserProvider>(context, listen: false).currentUser;
    Set<int> joinedIds = {};
    if (user != null) {
      final joined =
          await DatabaseHelper.instance.getUserChallenges(user.id!);
      joinedIds =
          joined.map((c) => c['id'] as int).toSet();
    }
    setState(() {
      _challenges = challenges;
      _joinedChallengeIds = joinedIds;
      _isLoading = false;
    });
  }

  Future<void> _joinChallenge(Challenge challenge) async {
    final user =
        Provider.of<UserProvider>(context, listen: false).currentUser;
    if (user != null && challenge.id != null) {
      await DatabaseHelper.instance
          .joinChallenge(user.id!, challenge.id!);
      setState(() => _joinedChallengeIds.add(challenge.id!));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Joined "${challenge.challengeName}"! +${challenge.points} points'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return const Color(0xFF4CAF50);
      case 'medium':
        return const Color(0xFFFF9800);
      case 'hard':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  IconData _getChallengeIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('plastic')) return Icons.delete_outline;
    if (lower.contains('energy')) return Icons.bolt;
    if (lower.contains('walk') || lower.contains('bike')) {
      return Icons.directions_walk;
    }
    if (lower.contains('food') || lower.contains('meatless')) {
      return Icons.restaurant;
    }
    if (lower.contains('waste') || lower.contains('zero')) {
      return Icons.recycling;
    }
    return Icons.eco;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sustainability Challenges'),
        backgroundColor: const Color(0xFF4CAF50),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _challenges.isEmpty
              ? const Center(child: Text('No challenges available'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _challenges.length,
                  itemBuilder: (context, index) {
                    final challenge = _challenges[index];
                    final isJoined =
                        _joinedChallengeIds.contains(challenge.id);
                    return _buildChallengeCard(challenge, isJoined);
                  },
                ),
    );
  }

  Widget _buildChallengeCard(Challenge challenge, bool isJoined) {
    final difficultyColor = _getDifficultyColor(challenge.difficulty);
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color:
                    const Color(0xFF4CAF50).withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getChallengeIcon(challenge.challengeName),
                color: const Color(0xFF4CAF50),
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          challenge.challengeName,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: difficultyColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          challenge.difficulty,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: difficultyColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${challenge.duration} days',
                    style: TextStyle(
                        fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    challenge.description ?? '',
                    style: TextStyle(
                        fontSize: 13, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.emoji_events,
                          color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${challenge.points} points',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      isJoined
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('Joined',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold)),
                            )
                          : ElevatedButton(
                              onPressed: () =>
                                  _joinChallenge(challenge),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF4CAF50),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(8)),
                                padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                              ),
                              child: const Text('Join',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
