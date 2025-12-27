import 'package:flutter/material.dart';

class JudgeLogin
    extends
        StatelessWidget {
  const JudgeLogin({
    super.key,
  });

  @override
  Widget
  build(
    BuildContext
    context,
  ) {
    final Color
    bgColor = const Color(
      0xFF0B1324,
    );
    final Color
    cardColor = const Color(
      0xFF1C2541,
    );
    final Color
    orangeBtn = const Color(
      0xFFE67E22,
    );
    final Color
    scoreBg = const Color(
      0xFF0B2540,
    );
    final Color
    yellowBtn = const Color(
      0xFFF1C40F,
    );
    final Color
    redBtn = const Color(
      0xFFE74C3C,
    );

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          'Judge — Scoring Demo Static',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          // Using ListView ensures everything is scrollable if screen is too small
          child: ListView(
            children: [
              // 1. Top Info Card
              Container(
                padding: const EdgeInsets.all(
                  16,
                ),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,

                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    // Player Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Name: Player1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Age:',
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Type: Double',
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Judge Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Judge',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          'judge1@gmail.com',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // 2. Main Scoring Area (The Big Buttons)
              // We give this a fixed height or let it expand, but using Expanded inside
              // ensures it pushes the finish button down.
              SizedBox(
                height:
                    MediaQuery.of(
                      context,
                    ).size.height *
                    0.5, // Take 50% of screen height
                child: Card(
                  color: bgColor, // Transparent/Same as bg to look seamless
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Top Controls Row
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.red[400],
                                    borderRadius: BorderRadius.circular(
                                      4,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Round : 1',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            // Small Buttons
                            Row(
                              children: [
                                _buildSmallButton(
                                  'Yellow 1',
                                  yellowBtn,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                _buildSmallButton(
                                  'Yellow 2',
                                  yellowBtn,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                _buildSmallButton(
                                  'Red',
                                  redBtn,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // The Big 3 Panels (Minus | Score | Plus)
                      // Using Expanded here makes them fill the remaining space vertically
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch, // Key: Makes children same height
                          children: [
                            // Minus Button
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: const EdgeInsets.only(
                                  right: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: orangeBtn,
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '−', // Using text for cleaner look than icon
                                    style: TextStyle(
                                      fontSize: 120,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Score Display
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: scoreBg,
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '5.00',
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Plus Button
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: orangeBtn,
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                      fontSize: 120,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // 3. Finish Button (Bottom Right)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: yellowBtn,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Finish',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for the small top buttons
  Widget
  _buildSmallButton(
    String
    text,
    Color
    color,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
