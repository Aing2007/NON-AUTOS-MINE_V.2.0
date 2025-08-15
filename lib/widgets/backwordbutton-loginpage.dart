import 'package:flutter/material.dart';
import '/utils/colors.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  const BackButtonWidget({
    Key? key,
    this.onPressed,
    this.top,
    this.left,
    this.right,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: GestureDetector(
        onTap: onPressed ?? () => Navigator.of(context).pop(),
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: AppColors.coral,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
