import 'package:flutter/material.dart';

class AppColors {
  // Yellow colors
  static const Color yellowPrimary = Color(0xFFFFD370);
  static const Color yellowSecondary = Color(0xFFFED371);
  
  // Brown colors
  static const Color brownPrimary = Color(0xFF5F4A46);
  static const Color brownSecondary = Color(0xFF805E57);
  static const Color brownTertiary = Color(0xFF9C8A87);
  static const Color brownLight = Color(0xFFC7B2AE);
  
  // Other colors
  static const Color cream = Color(0xFAF5EF);
  static const Color coral = Color(0xFFF65A3B);
  
  // Standard colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  
  // Primary app colors from Figma design
  static const Color appBlue = Color(0xFF7F95E4);
  static const Color appGreen = Color(0xFF8BC7AD);
  static const Color appGreenDark = Color(0xFF31A68E);
  
  static const Color appBrown = Color(0xFF805E57);
  static const Color appBrownLight = Color(0xFFC7B2AE);
  static const Color appBrownDark = Color(0xFF5F4A46);
  static const Color appBrownDarker = Color(0xFF9C8A87);
  
  static const Color appYellow = Color(0xFFFED371);
  static const Color appYellowLight = Color(0xFFFFDC8E);
  static const Color appYellowBright = Color(0xFFFFD370);
  
  static const Color appRed = Color(0xFFF65A3B);
  static const Color appPurple = Color(0xFFC3CFFF);
  static const Color appGray = Color(0xFFD9D9D9);
}

class AppTextStyles {
  static const TextStyle userNameStyle = TextStyle(
    color: AppColors.appBrownDark,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.35,
    fontFamily: 'Khula',
  );
  
  static const TextStyle balanceStyle = TextStyle(
    color: AppColors.appBrownDarker,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.35,
    fontFamily: 'Khula',
  );
  
  static const TextStyle navLabelStyle = TextStyle(
    color: AppColors.appGray,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    fontFamily: 'Khula',
  );
}

class AppSizes {
  static const double profileImageSize = 64.0;
  static const double balanceCardWidth = 216.0;
  static const double windowFrameSize = 267.0;
  static const double settingsPanelWidth = 53.0;
  static const double settingsPanelHeight = 186.0;
  static const double navIconSize = 50.0;
  static const double plantWidth = 80.0;
  static const double plantHeight = 176.0;
}
