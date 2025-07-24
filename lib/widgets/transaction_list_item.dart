import 'package:flutter/material.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_colors.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_styles.dart';

class TransactionListItem extends StatelessWidget {
  final String name;
  final String amount;
  final String date;
  final String type;

  const TransactionListItem({
    super.key,
    required this.name,
    required this.amount,
    required this.date,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSold = type == 'sold';
    final bool isUpcycled = type == 'upcycled';

    Color amountColor;
    Color iconBgColor;
    Color iconColor;
    IconData iconData;

    if (isSold) {
      amountColor = AppColors.green600;
      iconBgColor = AppColors.green100;
      iconColor = AppColors.green600;
      iconData = Icons.attach_money;
    } else if (isUpcycled) {
      amountColor = AppColors.purple600;
      iconBgColor = AppColors.purple100;
      iconColor = AppColors.purple600;
      iconData = Icons.lightbulb_outline;
    } else {
      amountColor = AppColors.gray800;
      iconBgColor = AppColors.gray100;
      iconColor = AppColors.gray600;
      iconData = Icons.info_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppStyles.textGray800
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4.0),
                Text(
                  date,
                  style: AppStyles.textGray600.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isSold ? '+' : ''}$amount',
                style: AppStyles.textBold.copyWith(color: amountColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
