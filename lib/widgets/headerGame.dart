import 'package:flutter/material.dart';

class GameHeader extends StatelessWidget {
  final String money;
  final String profileImage;

  const GameHeader({
    Key? key,
    required this.money,
    this.profileImage = 'assets/images/ICON.png', // ค่า default
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerIconSize = size.width * 0.18;
    final headerHeight = size.height * 0.08;

    return Row(
      children: [
        // วงกลมโปรไฟล์
        Container(
          width: headerIconSize * 0.9,
          height: headerIconSize * 0.9,
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
            image: DecorationImage(
              image: AssetImage(profileImage),
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
            height: headerHeight * 0.6,
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
                const Icon(Icons.attach_money, size: 18, color: Colors.amber),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    money,
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
          child: const Icon(Icons.location_pin, color: Colors.brown),
        ),
      ],
    );
  }
}
