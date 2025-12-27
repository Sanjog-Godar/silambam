import 'package:flutter/material.dart';
import 'category_details.dart';

class AllTournament
    extends
        StatelessWidget {
  const AllTournament({
    super.key,
  });

  @override
  Widget
  build(
    BuildContext
    context,
  ) {
    // Color Palette
    const Color
    darkNavyBg = Color(
      0xFF0B2340,
    );
    const Color
    cardBg = Color(
      0xFF143455,
    );
    const Color
    tealAccent = Color(
      0xFF27B7B0,
    );
    const Color
    orangeGold = Color(
      0xFFE3A23A,
    );

    return Scaffold(
      backgroundColor: darkNavyBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER
            _buildHeader(),

            // Divider line
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.white.withValues(
                alpha: 0.25,
              ),
            ),

            // 2. BODY - Scrollable tournament list
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 24.0,
                      ),
                      child: Text(
                        'All Tournaments',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Tournament cards list
                    _buildTournamentCard(
                      context,
                      'Test100',
                      'Pokhara sirjana Chowk',
                      '13:55:00',
                      cardBg,
                      tealAccent,
                      orangeGold,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    _buildTournamentCard(
                      context,
                      'solo testing',
                      'Testing',
                      '16:26:00',
                      cardBg,
                      tealAccent,
                      orangeGold,
                    ),

                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Header with Menu, Logo, and User
  Widget
  _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Row(
        children: [
          // Left: Hamburger menu icon
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),

          // Center: Logo
          Expanded(
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(
                      alpha: 0.3,
                    ),
                    width: 1.5,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://ocm.olympics.com.my/public/images/members/logos/member_logo_51.png',
                    fit: BoxFit.cover,
                    errorBuilder:
                        (
                          context,
                          error,
                          stackTrace,
                        ) => const Icon(
                          Icons.image,
                          color: Colors.white54,
                          size: 35,
                        ),
                  ),
                ),
              ),
            ),
          ),

          // Right: User profile section
          PopupMenuButton(
            onSelected:
                (
                  value,
                ) {},
            itemBuilder:
                (
                  BuildContext context,
                ) => [
                  const PopupMenuItem(
                    child: Text(
                      'Profile',
                    ),
                  ),
                  const PopupMenuItem(
                    child: Text(
                      'Logout',
                    ),
                  ),
                ],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  'tester1@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white.withValues(
                    alpha: 0.7,
                  ),
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Tournament Card
  Widget
  _buildTournamentCard(
    BuildContext
    context,
    String
    tournamentName,
    String
    venue,
    String
    time,
    Color
    cardBg,
    Color
    tealAccent,
    Color
    orangeGold,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(
          MaterialPageRoute(
            builder:
                (
                  context,
                ) => const CategoryDetails(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(
              16,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.25,
                ),
                blurRadius: 8,
                offset: const Offset(
                  0,
                  4,
                ),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Row(
              children: [
                // Left: Small logo thumbnail
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(
                        alpha: 0.2,
                      ),
                      width: 1,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://ocm.olympics.com.my/public/images/members/logos/member_logo_51.png',
                      fit: BoxFit.cover,
                      errorBuilder:
                          (
                            context,
                            error,
                            stackTrace,
                          ) => const Icon(
                            Icons.image,
                            color: Colors.white54,
                            size: 30,
                          ),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 16,
                ),

                // Middle: Tournament info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tournament name
                      Text(
                        tournamentName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      // Metadata row: Venue and Time
                      Row(
                        children: [
                          // Location
                          Icon(
                            Icons.location_on,
                            color: tealAccent,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              venue,
                              style: TextStyle(
                                color: Colors.white.withValues(
                                  alpha: 0.75,
                                ),
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          // Time
                          Icon(
                            Icons.access_time,
                            color: tealAccent,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            time,
                            style: TextStyle(
                              color: Colors.white.withValues(
                                alpha: 0.75,
                              ),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  width: 12,
                ),

                // Right: Orange chevron
                Icon(
                  Icons.chevron_right,
                  color: orangeGold,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
