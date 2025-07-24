import 'package:flutter/material.dart';
import 'package:waste_to_wealth_app_flutter/widgets/custom_button.dart';
import 'package:waste_to_wealth_app_flutter/widgets/custom_input_field.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_colors.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_styles.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLogin;

  const LoginPage({super.key, required this.onLogin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1), // Slight slide up
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward(); // Start animation on page load
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    setState(() {
      _isLoading = true;
    });
    // Simulate login process
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isLoading = false;
      });
      widget.onLogin(); // Navigate to dashboard
    });
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
              AppColors.green600, // Changed color
              AppColors.teal600, // Changed color
              AppColors.blueGrey800, // Changed color
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo/Brand
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.only(bottom: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Center(
                          // FIX: Replaced emoji with a standard Flutter Icon
                          child: Icon(
                            Icons
                                .recycling, // Using a Material Icon for recycling
                            size: 36,
                            color: AppColors
                                .green800, // Consistent with the app's theme
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'WasteToWealth', // Changed title
                      style: AppStyles.heading1.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Transforming Waste into Value', // Changed tagline
                      style: AppStyles
                          .textGreen100, // Changed style to a green variant
                    ),
                    const SizedBox(height: 32.0),

                    // Login Form Card
                    Card(
                      // Removed the deprecated ignore comment
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(
                          0.95), // This is the correct way to set card color
                      elevation: 16,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Welcome Back',
                              style: AppStyles.heading2
                                  .copyWith(color: AppColors.gray800),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Sign in to your account',
                              style:
                                  AppStyles.textGray600.copyWith(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24.0),

                            // Email Field
                            CustomInputField(
                              controller: _emailController,
                              labelText: 'Email Address',
                              hintText: 'Enter your email',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.mail_outline,
                            ),
                            const SizedBox(height: 16.0),

                            // Password Field
                            CustomInputField(
                              controller: _passwordController,
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              obscureText: true,
                              prefixIcon: Icons.lock_outline,
                            ),
                            const SizedBox(height: 24.0),

                            // Login Button
                            CustomButton(
                              onPressed: _handleLogin,
                              isLoading: _isLoading,
                              label: _isLoading ? 'Signing In...' : 'Sign In',
                              icon: _isLoading ? null : Icons.arrow_right_alt,
                              gradientColors: const [
                                AppColors.green600,
                                AppColors.teal600
                              ], // Changed gradient colors
                              textStyle: AppStyles.buttonText,
                            ),
                            const SizedBox(height: 16.0),

                            // Demo Note
                            Text(
                              'Demo app - Tap "Sign In" to continue',
                              style:
                                  AppStyles.textGray500.copyWith(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
