import 'package:flutter/material.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_colors.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_styles.dart';

enum AlertType { success, error }

class CustomAlert extends StatefulWidget {
  final String message;
  final AlertType type;
  final Duration animationDelay;

  const CustomAlert({
    super.key,
    required this.message,
    this.type = AlertType.success,
    this.animationDelay = const Duration(milliseconds: 0),
  });

  @override
  State<CustomAlert> createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    Future.delayed(widget.animationDelay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Color borderColor;
    IconData icon;

    switch (widget.type) {
      case AlertType.success:
        bgColor = AppColors.green50;
        textColor = AppColors.green800;
        borderColor = AppColors.green600;
        icon = Icons.check_circle_outline;
        break;
      case AlertType.error:
        bgColor = AppColors.red50;
        textColor = AppColors.red800;
        borderColor = AppColors.red200;
        icon = Icons.error_outline;
        break;
    }

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: borderColor, width: 1.0),
        ),
        child: Row(
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                widget.message,
                style: AppStyles.textSmall.copyWith(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
