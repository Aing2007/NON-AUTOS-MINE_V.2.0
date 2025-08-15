import 'package:flutter/material.dart';
import '/utils/colors.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  
  const BackButtonWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.of(context).pop(),
      child: Container(
        width: 45,
        height: 45,
        decoration: const BoxDecoration(
          color: AppColors.coral,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
