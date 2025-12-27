import 'package:flutter/material.dart';
import 'tournament_details.dart';

class CategoryDetails
    extends
        StatelessWidget {
  const CategoryDetails({
    super.key,
  });

  @override
  Widget
  build(
    BuildContext
    context,
  ) {
    // Color Palette from design prompt
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header with back arrow and logo
              _buildHeader(
                context,
              ),

              // Divider line
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.white.withValues(
                  alpha: 0.25,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              // 2. Tournament Details Card
              _buildTournamentDetailsCard(
                cardBg,
                tealAccent,
                orangeGold,
              ),

              const SizedBox(
                height: 28,
              ),

              // 3. "List of Categories" heading
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: Text(
                  'List of Categories',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              // 4. Category List Item
              _buildCategoryCard(
                context,
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
    );
  }

  /// Header with Back Button and Centered Logo
  Widget
  _buildHeader(
    BuildContext
    context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Back arrow (left)
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () => Navigator.of(
                context,
              ).pop(),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          // Centered logo
          Container(
            width: 64,
            height: 64,
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
                      size: 40,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Tournament Details Card
  Widget
  _buildTournamentDetailsCard(
    Color
    cardBg,
    Color
    tealAccent,
    Color
    orangeGold,
  ) {
    return Padding(
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
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title with orange underline
              Stack(
                children: [
                  const Text(
                    'Tournaments Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Positioned(
                    bottom: -4,
                    left: 0,
                    child: Container(
                      width: 80,
                      height: 2,
                      color: orangeGold,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 16,
              ),

              // Test100 title
              const Text(
                'Test100',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              // Venue and Time metadata
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: tealAccent,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Expanded(
                    child: Text(
                      'Venue: Pokhara sirjana Chowk',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 8,
              ),

              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: tealAccent,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'Time: 22:10:00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Category List Item Card
  Widget
  _buildCategoryCard(
    BuildContext
    context,
    Color
    cardBg,
    Color
    tealAccent,
    Color
    orangeGold,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).push(
            MaterialPageRoute(
              builder:
                  (
                    context,
                  ) => const TournamentDetails(),
            ),
          );
        },
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
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Row(
              children: [
                // Left content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // GroupTest100 - double
                      Row(
                        children: [
                          const Text(
                            'GroupTest100 - ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'double',
                            style: TextStyle(
                              color: tealAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      // Number "2" in orange/gold
                      Text(
                        '2',
                        style: TextStyle(
                          color: orangeGold,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      // "ongoing" status chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(
                            alpha: 0.3,
                          ),
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          border: Border.all(
                            color: Colors.white.withValues(
                              alpha: 0.2,
                            ),
                            width: 0.5,
                          ),
                        ),
                        child: const Text(
                          'ongoing',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  width: 16,
                ),

                // Right chevron
                Icon(
                  Icons.chevron_right,
                  color: Colors.white.withValues(
                    alpha: 0.6,
                  ),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
