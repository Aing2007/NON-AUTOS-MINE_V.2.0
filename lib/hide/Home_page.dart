import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Column(
                  children: [
                    // User Info
                    Row(
                      children: [
                        // Profile Image
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: Container(
                              color: const Color(0xFF8BC7AD),
                              child: Image.network(
                                'https://cdn.builder.io/api/v1/assets/3e98c2e405b4425fb9cb2adbdf1ba7a8/figma-screenshot-e70c86?format=webp&width=800',
                                width: 74,
                                height: 74,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // User Name
                        const Expanded(
                          child: Text(
                            'SUTINAN SRIVISET',
                            style: TextStyle(
                              color: Color(0xFF5F4A46),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Balance Card
                    Container(
                      width: 216,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFD370),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.monetization_on,
                              color: Color(0xFFFFD370),
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            '12,000,000.00',
                            style: TextStyle(
                              color: Color(0xFF9C8A87),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Main Content Area
              Expanded(
                child: Stack(
                  children: [
                    // Window Illustration
                    Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 298,
                          height: 337,
                          child: Stack(
                            children: [
                              // Left Curtain
                              Positioned(
                                left: 7,
                                top: 0,
                                child: Container(
                                  width: 64,
                                  height: 328,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFED371),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 28,
                                top: 0,
                                child: Container(
                                  width: 44,
                                  height: 337,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFDC8E),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              // Right Curtain
                              Positioned(
                                right: 7,
                                top: 0,
                                child: Container(
                                  width: 64,
                                  height: 328,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFED371),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 28,
                                top: 0,
                                child: Container(
                                  width: 44,
                                  height: 337,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFDC8E),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              // Window Frame
                              Positioned(
                                left: 15,
                                top: 37,
                                child: Container(
                                  width: 267,
                                  height: 267,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC3CFFF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF805E57),
                                      width: 15,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Window Cross Bars
                                      Positioned(
                                        top: 118,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: 15,
                                          color: const Color(0xFF805E57),
                                        ),
                                      ),
                                      Positioned(
                                        left: 118,
                                        top: 0,
                                        bottom: 0,
                                        child: Container(
                                          width: 15,
                                          color: const Color(0xFF805E57),
                                        ),
                                      ),
                                      // Clouds
                                      Positioned(
                                        top: 40,
                                        right: 30,
                                        child: _buildCloud(60, 35),
                                      ),
                                      Positioned(
                                        bottom: 50,
                                        left: 30,
                                        child: _buildCloud(40, 25),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Window Frame Top
                              Positioned(
                                top: 4,
                                left: 7,
                                right: 7,
                                child: Container(
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF805E57),
                                    borderRadius: BorderRadius.circular(1.5),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF805E57),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF805E57),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Character Image
                    Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 282,
                          height: 504,
                          child: Image.network(
                            'https://cdn.builder.io/api/v1/assets/3e98c2e405b4425fb9cb2adbdf1ba7a8/figma-screenshot-e70c86?format=webp&width=800',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    // Plant
                    Positioned(bottom: 130, right: 30, child: _buildPlant()),
                    // Settings Panel
                    Positioned(
                      top: 40,
                      right: 20,
                      child: _buildSettingsPanel(),
                    ),
                  ],
                ),
              ),
              // Bottom Section
              Stack(
                children: [
                  // Background Shape
                  Container(
                    width: double.infinity,
                    height: 147,
                    color: const Color(0xFF9C8A87),
                  ),
                  // Ground Shadow
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 217,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFF5F4A46),
                          borderRadius: BorderRadius.circular(21),
                        ),
                      ),
                    ),
                  ),
                  // Bottom Navigation
                  Positioned(
                    top: -10,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Home
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Color(0xFF7F95E4),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.home,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          // Game
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                child: const Icon(
                                  Icons.gamepad,
                                  color: Color(0xFFD9D9D9),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'GAME',
                                style: TextStyle(
                                  color: Color(0xFFD9D9D9),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          // Profile
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                child: const Icon(
                                  Icons.person,
                                  color: Color(0xFFD9D9D9),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'PROFILE',
                                style: TextStyle(
                                  color: Color(0xFFD9D9D9),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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

  Widget _buildCloud(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width / 2),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -width * 0.15,
            top: height * 0.1,
            child: Container(
              width: width * 0.4,
              height: height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width * 0.2),
              ),
            ),
          ),
          Positioned(
            right: width * 0.05,
            top: -height * 0.1,
            child: Container(
              width: width * 0.3,
              height: height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width * 0.15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlant() {
    return Container(
      width: 80,
      height: 176,
      child: Stack(
        children: [
          // Plant Pot
          Positioned(
            bottom: 0,
            child: Container(
              width: 80,
              height: 64,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 8,
                    child: Container(
                      width: 80,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFF805E57),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 80,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC7B2AE),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Plant Stem
          Positioned(
            bottom: 48,
            left: 39,
            child: Container(
              width: 4,
              height: 96,
              color: const Color(0xFF31A68E),
            ),
          ),
          // Leaves
          Positioned(
            bottom: 144,
            left: 36,
            child: Transform.rotate(
              angle: 0.785, // 45 degrees
              child: Container(
                width: 32,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF8BC7AD),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 128,
            left: 60,
            child: Container(
              width: 20,
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF8BC7AD),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            bottom: 96,
            right: 24,
            child: Container(
              width: 20,
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF8BC7AD),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 36,
            child: Transform.rotate(
              angle: -0.21, // -12 degrees
              child: Container(
                width: 32,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF8BC7AD),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 24,
            child: Container(
              width: 20,
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF8BC7AD),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            bottom: 160,
            left: 4,
            child: Container(
              width: 40,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF8BC7AD),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsPanel() {
    return Container(
      width: 53,
      height: 186,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFF5F4A46),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.settings, color: Colors.white, size: 20),
          ),
          Container(
            width: 28,
            height: 20,
            decoration: BoxDecoration(
              color: const Color(0xFFFED371),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.mail, color: Color(0xFF5F4A46), size: 16),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF7F95E4),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.store, color: Colors.white, size: 16),
          ),
          Container(
            width: 28,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFF65A3B),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
