import 'package:flutter/material.dart';
import 'judge_login.dart';

class TournamentDetails extends StatelessWidget {
  const TournamentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // Exact Color Palette from your design
    const Color darkNavyBg = Color(0xFF050C1D);
    const Color lightNavyCard = Color(0xFF1A2641);
    const Color coralRed = Color(0xFFF4511E);
    const Color cyanInfo = Colors.cyanAccent;

    return Scaffold(
      backgroundColor: darkNavyBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Custom Header
              _buildHeader(context),

              const SizedBox(height: 20),

              // 2. Tournament Information Card
              _buildTournamentCard(lightNavyCard, const Color.fromARGB(255, 224, 221, 217), cyanInfo),

              const SizedBox(height: 30),

              // 3. List Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'List of Players',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 4. Player List Item
              _buildPlayerCard(context, coralRed),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// Header with Back Button and Centered Network Logo
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.chevron_left, color: Color.fromARGB(255, 234, 228, 228), size: 36),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24, width: 2),
            ),
            child: ClipOval(
              child: Image.network(
                'https://ocm.olympics.com.my/public/images/members/logos/member_logo_51.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, color: Colors.white54, size: 50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// The Main Tournament Detail Card (Navy Blue)
  Widget _buildTournamentCard(Color cardBg, Color orange, Color cyan) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // Top Orange Accent Bar
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: orange,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Test100',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Text('GroupTest100',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text('double',
                        style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: cyan, size: 18),
                      const SizedBox(width: 4),
                      const Text('Pokhara sirjana Chowk',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time, color: cyan, size: 18),
                      const SizedBox(width: 4),
                      const Text('22:10:00',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
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

  /// The Red Player Action Card
  Widget _buildPlayerCard(BuildContext context, Color cardColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const JudgeLogin()),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Player1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '15 - female',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}