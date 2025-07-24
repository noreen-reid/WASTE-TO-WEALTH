import 'package:flutter/material.dart';
import 'package:waste_to_wealth_app_flutter/widgets/custom_button.dart';
import 'package:waste_to_wealth_app_flutter/widgets/dashboard_balance_card.dart';
import 'package:waste_to_wealth_app_flutter/widgets/dashboard_quick_action_card.dart';
import 'package:waste_to_wealth_app_flutter/widgets/transaction_list_item.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_colors.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_styles.dart';

class DashboardPage extends StatefulWidget {
  final VoidCallback onConnectEarn;
  final VoidCallback onLogout;

  const DashboardPage(
      {super.key, required this.onConnectEarn, required this.onLogout});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _recentTransactions = [
    {
      'name': 'Plastic Bottles',
      'amount': '2.5 kg',
      'date': 'Today',
      'type': 'sold'
    },
    {
      'name': 'Old Tires',
      'amount': '2 pcs',
      'date': 'Yesterday',
      'type': 'upcycled'
    },
    {
      'name': 'Fabric Scraps',
      'amount': '0.8 kg',
      'date': '2 days ago',
      'type': 'sold'
    },
  ];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.green50,
              AppColors.teal50,
              AppColors.blueGrey50,
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 120.0,
                floating: true,
                pinned: false,
                snap: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dashboard',
                                  style: AppStyles.heading1
                                      .copyWith(color: AppColors.gray800),
                                ),
                                const SizedBox(height: 4.0),
                                const Text(
                                  'Welcome back! Manage your waste-to-wealth journey.',
                                  style: AppStyles.textGray600,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: widget.onLogout,
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      // ignore: deprecated_member_use
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.logout,
                                    color: AppColors.green800),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 16.0),
                      const DashboardBalanceCard(
                        balance: '2,847.50',
                        monthlyChange: '+180.00',
                        percentageChange: '+6.8%',
                        animationDelay: Duration(milliseconds: 100),
                      ),
                      const SizedBox(height: 32.0),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 700 ? 3 : 1,
                        crossAxisSpacing: 24.0,
                        mainAxisSpacing: 24.0,
                        childAspectRatio:
                            MediaQuery.of(context).size.width > 700 ? 1.0 : 1.5,
                        children: [
                          DashboardQuickActionCard(
                            icon: Icons.qr_code_scanner,
                            iconColor: AppColors.green600,
                            iconBgColor: AppColors.green100,
                            title: 'Scan Waste',
                            description: 'Identify waste & get ideas',
                            buttonLabel: 'Scan Now',
                            onPressed: widget.onConnectEarn,
                            buttonColor: AppColors.green600,
                            animationDelay: const Duration(milliseconds: 200),
                          ),
                          DashboardQuickActionCard(
                            icon: Icons.history,
                            iconColor: AppColors.blue600,
                            iconBgColor: AppColors.blue100,
                            title: 'Activity Log',
                            description: 'View all your waste activities',
                            buttonLabel: 'View Log',
                            onPressed: () {},
                            buttonColor: AppColors.blue600,
                            buttonVariant: ButtonVariant.outline,
                            animationDelay: const Duration(milliseconds: 300),
                          ),
                          DashboardQuickActionCard(
                            icon: Icons.local_offer,
                            iconColor: AppColors.purple600,
                            iconBgColor: AppColors.purple100,
                            title: 'Marketplace',
                            description: 'Browse items & sell your creations',
                            buttonLabel: 'Explore',
                            onPressed: () {},
                            buttonColor: AppColors.purple600,
                            buttonVariant: ButtonVariant.outline,
                            animationDelay: const Duration(milliseconds: 400),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.1),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(0.5, 1.0,
                                  curve: Curves.easeOut))),
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.receipt_long,
                                          color: AppColors.green800, size: 24),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'Recent Activities',
                                        style: AppStyles.heading3,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: _recentTransactions.length,
                                    separatorBuilder: (context, index) =>
                                        const Divider(height: 24.0),
                                    itemBuilder: (context, index) {
                                      final transaction =
                                          _recentTransactions[index];
                                      return TransactionListItem(
                                        name: transaction['name'],
                                        amount: transaction['amount'],
                                        date: transaction['date'],
                                        type: transaction['type'],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
