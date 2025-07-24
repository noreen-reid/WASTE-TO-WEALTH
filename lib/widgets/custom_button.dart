import 'package:flutter/material.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_colors.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_styles.dart';

enum ButtonVariant {
  defaultButton,
  outline,
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData? icon;
  final bool isLoading;
  final List<Color> gradientColors;
  final ButtonVariant buttonVariant;
  final TextStyle? textStyle;
  final Color? buttonColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.isLoading = false,
    this.gradientColors = const [],
    this.buttonVariant = ButtonVariant.defaultButton,
    this.textStyle,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonChild = isLoading
        ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 24, color: textStyle?.color ?? Colors.white),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: textStyle ?? AppStyles.buttonText,
              ),
            ],
          );

    if (buttonVariant == ButtonVariant.outline) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: buttonColor ?? AppColors.green600, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          textStyle: AppStyles.buttonText
              .copyWith(color: buttonColor ?? AppColors.green600),
          foregroundColor: buttonColor ?? AppColors.green600,
          backgroundColor: Colors.white,
          elevation: 4,
          // ignore: deprecated_member_use
          shadowColor: Colors.black.withOpacity(0.1),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                // ignore: deprecated_member_use
                return (buttonColor ?? AppColors.green600).withOpacity(0.05);
              }
              return null;
            },
          ),
        ),
        child: buttonChild,
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: gradientColors.isNotEmpty
            ? LinearGradient(
                colors: gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color:
            gradientColors.isEmpty ? (buttonColor ?? AppColors.green600) : null,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: (buttonColor ?? AppColors.green600).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12.0),
          // ignore: deprecated_member_use
          highlightColor: Colors.white.withOpacity(0.1),
          // ignore: deprecated_member_use
          splashColor: Colors.white.withOpacity(0.2),
          child: Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: buttonChild,
          ),
        ),
      ),
    );
  }
}
