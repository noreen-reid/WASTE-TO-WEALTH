import 'package:flutter/material.dart';
import 'package:waste_to_wealth_app_flutter/widgets/custom_button.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_styles.dart';

class DashboardQuickActionCard extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;
  final Color buttonColor;
  final ButtonVariant buttonVariant;
  final Duration animationDelay;

  const DashboardQuickActionCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
    required this.buttonColor,
    this.buttonVariant = ButtonVariant.defaultButton,
    this.animationDelay = const Duration(milliseconds: 0),
  });

  @override
  State<DashboardQuickActionCard> createState() =>
      _DashboardQuickActionCardState();
}

class _DashboardQuickActionCardState extends State<DashboardQuickActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(16.0),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: widget.iconBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(widget.icon, color: widget.iconColor, size: 36),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    widget.title,
                    style: AppStyles.heading4,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.description,
                    style: AppStyles.textGray600.copyWith(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  CustomButton(
                    onPressed: widget.onPressed,
                    label: widget.buttonLabel,
                    buttonColor: widget.buttonColor,
                    buttonVariant: widget.buttonVariant,
                    textStyle: widget.buttonVariant == ButtonVariant.outline
                        ? AppStyles.buttonText
                            .copyWith(color: widget.buttonColor)
                        : AppStyles.buttonText.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
