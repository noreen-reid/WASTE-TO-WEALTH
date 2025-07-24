import 'package:flutter/material.dart';
import 'package:waste_to_wealth_app_flutter/widgets/custom_button.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_colors.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_styles.dart';

class AnimatedSendButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String label;
  final IconData? icon;
  final List<Color> gradientColors;

  const AnimatedSendButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    required this.label,
    this.icon,
    this.gradientColors = const [AppColors.green600, AppColors.teal600],
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      isLoading: isLoading,
      label: label,
      icon: icon,
      gradientColors: gradientColors,
      textStyle: AppStyles.buttonText.copyWith(color: Colors.white),
    );
  }
}
