import 'package:flutter/material.dart';
import 'package:waste_to_wealth_app_flutter/widgets/animated_send_button.dart';
import 'package:waste_to_wealth_app_flutter/widgets/custom_alert.dart';
import 'package:waste_to_wealth_app_flutter/widgets/custom_dropdown.dart';
import 'package:waste_to_wealth_app_flutter/widgets/custom_input_field.dart';
import 'package:waste_to_wealth_app_flutter/widgets/custom_switch.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_colors.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_styles.dart';

class ConnectEarnPage extends StatefulWidget {
  final VoidCallback onBackToDashboard;

  const ConnectEarnPage({super.key, required this.onBackToDashboard});

  @override
  State<ConnectEarnPage> createState() => _ConnectEarnPageState();
}

class _ConnectEarnPageState extends State<ConnectEarnPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String? _selectedCategory;
  bool _isMarketplaceListing = false;
  bool _showSuccess = false;
  bool _isProcessing = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _quantityController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleConnectEarn() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _showSuccess = true;
          _isProcessing = false;
        });

        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            _showSuccess = false;
            _itemNameController.clear();
            _quantityController.clear();
            _selectedCategory = null;
            _isMarketplaceListing = false;
          });
        });
      });
    }
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
          child: SlideTransition(
            position: _slideAnimation,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 120.0,
                  floating: true,
                  pinned: false,
                  snap: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon:
                        const Icon(Icons.arrow_back, color: AppColors.green800),
                    onPressed: widget.onBackToDashboard,
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.only(
                          top: 60.0, bottom: 16.0, left: 24.0, right: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
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
                            child: const Icon(Icons.recycling,
                                color: AppColors.green800, size: 36),
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            'Connect & Earn',
                            style: AppStyles.heading2
                                .copyWith(color: AppColors.gray800),
                          ),
                          const SizedBox(height: 4.0),
                          const Text(
                            'Monetize your waste and upcycled goods',
                            style: AppStyles.textGray600,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        if (_showSuccess)
                          CustomAlert(
                            message:
                                'Your item "${_itemNameController.text.trim()}" is now listed! ♻️',
                            type: AlertType.success,
                            animationDelay: const Duration(milliseconds: 0),
                          ),
                        const SizedBox(height: 24.0),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: _isProcessing
                                ? [
                                    BoxShadow(
                                      // ignore: deprecated_member_use
                                      color:
                                          // ignore: deprecated_member_use
                                          AppColors.green600.withOpacity(0.3),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      // ignore: deprecated_member_use
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Item Details',
                                    style: AppStyles.heading3
                                        .copyWith(color: AppColors.green800),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Divider(height: 32.0),
                                  CustomInputField(
                                    controller: _itemNameController,
                                    labelText: 'Item Name/Type',
                                    hintText:
                                        'e.g., Plastic Bottles, Old Tires, Upcycled Bag',
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Item name/type cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 24.0),
                                  CustomInputField(
                                    controller: _quantityController,
                                    labelText:
                                        'Quantity/Weight (e.g., pcs, kg)',
                                    hintText: 'e.g., 5 pcs, 2.5 kg',
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Quantity/Weight cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 24.0),
                                  CustomDropdown(
                                    labelText: 'Category',
                                    hintText: 'Choose category',
                                    value: _selectedCategory,
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'plastic',
                                        child: Row(
                                          children: [
                                            Icon(Icons.recycling,
                                                size: 20,
                                                color: AppColors.gray600),
                                            SizedBox(width: 10),
                                            Text('Plastics'),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'metal',
                                        child: Row(
                                          children: [
                                            Icon(Icons.build,
                                                size: 20,
                                                color: AppColors.gray600),
                                            SizedBox(width: 10),
                                            Text('Metals'),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'paper',
                                        child: Row(
                                          children: [
                                            Icon(Icons.description,
                                                size: 20,
                                                color: AppColors.gray600),
                                            SizedBox(width: 10),
                                            Text('Paper/Cardboard'),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'textile',
                                        child: Row(
                                          children: [
                                            Icon(Icons.cut,
                                                size: 20,
                                                color: AppColors.gray600),
                                            SizedBox(width: 10),
                                            Text('Textiles'),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'upcycled_product',
                                        child: Row(
                                          children: [
                                            Icon(Icons.lightbulb_outline,
                                                size: 20,
                                                color: AppColors.gray600),
                                            SizedBox(width: 10),
                                            Text('Upcycled Product'),
                                          ],
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCategory = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select a category';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 24.0),
                                  CustomSwitch(
                                    label: 'List on Marketplace',
                                    description:
                                        'Make this item available for others to buy',
                                    value: _isMarketplaceListing,
                                    onChanged: (value) {
                                      setState(() {
                                        _isMarketplaceListing = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 32.0),
                                  AnimatedSendButton(
                                    onPressed: _handleConnectEarn,
                                    isLoading: _isProcessing,
                                    label: _isProcessing
                                        ? 'Listing...'
                                        : 'List Item',
                                    icon: _isProcessing
                                        ? null
                                        : Icons.add_shopping_cart,
                                    gradientColors: const [
                                      AppColors.green600,
                                      AppColors.teal600
                                    ],
                                  ),
                                ],
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
      ),
    );
  }
}
