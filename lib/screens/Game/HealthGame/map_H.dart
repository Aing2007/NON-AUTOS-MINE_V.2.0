import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../LenguageGame/Level1/1.1.dart';
import '../LenguageGame/Level1/1.2.dart';

class MAPHscreen extends StatelessWidget {
  const MAPHscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // ขนาดหน้าจอ
    final buttonSize = size.width * 0.22; // ✅ ปุ่มกว้าง/สูง 22% ของหน้าจอ
    final headerIconSize = size.width * 0.18; // ✅ ขนาดโปรไฟล์ไอคอน
    final headerHeight = size.height * 0.08; // ✅ ความสูงกล่องเงิน

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 ภาพพื้นหลัง
          Positioned.fill(
            child: Image.asset(
              'assets/images/GamemapBG/GAME_H.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 เนื้อหาหลัก (Header + กลางจอ)
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: Column(
                children: [
                  // 🔸 Header บน
                  Row(
                    children: [
                      // วงกลมโปรไฟล์
                      Container(
                        width: headerIconSize,
                        height: headerIconSize,
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
                            image: AssetImage('assets/images/ICON.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(width: size.width * 0.03),

                      // ชื่อ + ยอดเงิน
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03,
                            vertical: size.height * 0.01,
                          ),
                          height: headerHeight,
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
                                size: 18,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  '12,000,000.00',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.04,
                                    color: Colors.brown,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: size.width * 0.03),

                      // ปุ่ม location
                      Container(
                        width: headerIconSize * 0.5,
                        height: headerIconSize * 0.5,
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

                  SizedBox(height: size.height * 0.02),

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
            bottom: 30,
            child: Container(
              color: const Color.fromARGB(0, 149, 228, 228),
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
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
                  }, buttonSize),
                  _buildBottomButton('03', null, () {
                    //Navigator.push(
                    // context,
                    //MaterialPageRoute(
                    // builder: (context) => TTSscreen(),
                    //),
                    //);
                  }, buttonSize),
                  _buildBottomButton('', Icons.lock, null, buttonSize),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 ปุ่มล่าง reusable (responsive)
  Widget _buildBottomButton(
    String label,
    IconData? icon,
    VoidCallback? onTap,
    double size,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size * 1.2,
        height: size * 1.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size * 0.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, size: size * 0.3, color: const Color(0xFF8BC7AD))
              : Text(
                  label,
                  style: TextStyle(
                    fontSize: size * 0.45,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF8BC7AD),
                  ),
                ),
        ),
      ),
    );
  }
}
