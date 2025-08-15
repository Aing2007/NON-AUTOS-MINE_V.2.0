import 'package:flutter/material.dart';
import '../LenguageGame/Level1/1.1.dart';
import '../LenguageGame/Level1/1.2.dart';

class MAPLscreen extends StatelessWidget {
  const MAPLscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 ภาพพื้นหลัง
          Positioned.fill(
            child: Image.asset(
              'assets/images/GAME_L.png', // ✅ ลบ '/' หน้าพาธ
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 เนื้อหาหลัก (Header + กลางจอ)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Column(
                children: [
                  // 🔸 Header บน
                  Row(
                    children: [
                      // วงกลมแดง
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/ICON.png',
                            ), // ✅ เปลี่ยน path ให้ถูกต้อง
                            fit: BoxFit
                                .cover, // หรือ BoxFit.contain ตามความต้องการ
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // ชื่อ + ยอดเงิน
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.attach_money,
                                size: 16,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 4),
                              const Expanded(
                                child: Text(
                                  '12,000,000.00',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.brown,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // ปุ่ม location
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 🔸 พื้นที่ว่างตรงกลาง
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),

          // 🔸 แถบปุ่มด้านล่าง
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 1000,
            child: Container(
              color: const Color(0xFF7F95E4),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomButton('01', null, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GameWidgetWithUI(game: SideScrollGame()),
                      ),
                    );
                  }),
                  _buildBottomButton('02', null, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GameWidgetWithUI(game: SideScrollGame()),
                      ),
                    );
                  }),
                  _buildBottomButton(
                    '',
                    Icons.lock,
                    null,
                  ), // ปุ่มล็อก ไม่มี onTap
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 ปุ่มล่าง reusable
  Widget _buildBottomButton(String label, IconData? icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, size: 30, color: Color(0xFF7F95E4))
              : Text(
                  label,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7F95E4),
                  ),
                ),
        ),
      ),
    );
  }
}
