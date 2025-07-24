import 'package:flutter/material.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_colors.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_styles.dart';

class DashboardBalanceCard extends StatefulWidget {
  final String balance;
  final String monthlyChange;
  final String percentageChange;
  final Duration animationDelay;

  const DashboardBalanceCard({
    super.key,
    required this.balance,
    required this.monthlyChange,
    required this.percentageChange,
    this.animationDelay = const Duration(milliseconds: 0),
  });

  @override
  State<DashboardBalanceCard> createState() => _DashboardBalanceCardState();
}

class _DashboardBalanceCardState extends State<DashboardBalanceCard>
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
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
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
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.green600, AppColors.teal600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Value Generated',
                    style: AppStyles.textGreen100.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'KES ${widget.balance}',
                    style: AppStyles.heading1
                        .copyWith(color: Colors.white, fontSize: 36),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '+KES ${widget.monthlyChange} this month',
                    style: AppStyles.textGreen100.copyWith(fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.trending_up,
                      color: AppColors.green600, size: 48),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.percentageChange,
                    style: AppStyles.textGreen100.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
