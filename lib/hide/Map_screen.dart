import 'package:flutter/material.dart';

class MapGameScreen extends StatelessWidget {
  const MapGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // game-background
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 448), // max-w-md equivalent
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side - AING branding
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF5449), // game-red
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'AING',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937), // gray-800
                        ),
                      ),
                    ],
                  ),
                  // Right side - Balance display
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF2C762), // game-yellow
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              '\$',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '12,000,000.00',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937), // gray-800
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Main Game Area
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Green Lock
                      _buildLockCircle(
                        color: const Color(0xFF7DD3AF), // game-green
                        hasIcon: true,
                        triangleColor: const Color(0xFF7DD3AF),
                      ),

                      // Yellow Lock
                      _buildLockCircle(
                        color: const Color(0xFFF2C762), // game-yellow
                        hasIcon: true,
                        triangleColor: const Color(0xFFF2C762),
                      ),

                      // Red Lock
                      _buildLockCircle(
                        color: const Color(0xFFFF5449), // game-red
                        hasIcon: true,
                        triangleColor: const Color(0xFFFF5449),
                      ),

                      // Blue Circle (no icon)
                      _buildLockCircle(
                        color: const Color(0xFF6B9BF7), // game-blue
                        hasIcon: false,
                        triangleColor: const Color(0xFF6B9BF7),
                      ),

                      // Image Circle
                      _buildImageCircle(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFE5E7EB), width: 1), // gray-200
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home Button
            _buildNavButton(icon: Icons.home_outlined, label: 'HOME'),

            // Center Action Button
            Transform.translate(
              offset: const Offset(0, -8),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2C762), // game-yellow
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(Icons.star, color: Colors.white, size: 32),
              ),
            ),

            // Profile Button
            _buildNavButton(icon: Icons.person_outline, label: 'PROFILE'),
          ],
        ),
      ),
    );
  }

  Widget _buildLockCircle({
    required Color color,
    required bool hasIcon,
    required Color triangleColor,
  }) {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: hasIcon
              ? const Icon(Icons.lock_outline, color: Colors.white, size: 32)
              : null,
        ),
        const SizedBox(height: 8),
        CustomPaint(
          size: const Size(16, 12),
          painter: TrianglePainter(color: triangleColor),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildImageCircle() {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
            image: const DecorationImage(
              image: AssetImage('assets/images/head.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        CustomPaint(
          size: const Size(16, 12),
          painter: TrianglePainter(color: Color(0xFF9CA3AF)),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildNavButton({required IconData icon, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF9CA3AF),
              width: 2,
            ), // gray-400
          ),
          child: Icon(
            icon,
            color: const Color(0xFF9CA3AF), // gray-400
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF9CA3AF), // gray-400
          ),
        ),
      ],
    );
  }
}

// Custom painter for triangular arrows
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, size.height); // Bottom point
    path.lineTo(0, 0); // Top left
    path.lineTo(size.width, 0); // Top right
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Main app wrapper
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AING Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter', // You can customize this
      ),
      home: const MapGameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  runApp(const MyApp());
}
