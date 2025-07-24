import 'package:flutter/material.dart';
import 'package:waste_to_wealth_app_flutter/screens/login_page.dart';
import 'package:waste_to_wealth_app_flutter/screens/dashboard_page.dart';
import 'package:waste_to_wealth_app_flutter/screens/connect_earn_page.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_colors.dart';
import 'package:waste_to_wealth_app_flutter/utils/app_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _currentPage = 'login';

  void _navigateToDashboard() {
    setState(() {
      _currentPage = 'dashboard';
    });
  }

  void _navigateToConnectEarn() {
    setState(() {
      _currentPage = 'connectEarn';
    });
  }

  void _navigateToLogin() {
    setState(() {
      _currentPage = 'login';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WasteToWealth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: AppColors.backgroundGradientStart,
        fontFamily: 'Inter',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.green800),
          titleTextStyle: TextStyle(
            color: AppColors.gray800,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 8,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColors.green600, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColors.red500, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColors.red700, width: 2.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          hintStyle: AppStyles.textGray500,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: AppStyles.buttonText,
            // ignore: deprecated_member_use
            shadowColor: Colors.black.withOpacity(0.2),
            elevation: 8,
          ),
        ),
      ),
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: _getPage(_currentPage),
      ),
    );
  }

  Widget _getPage(String pageName) {
    switch (pageName) {
      case 'login':
        return LoginPage(
            key: const ValueKey('LoginPage'), onLogin: _navigateToDashboard);
      case 'dashboard':
        return DashboardPage(
            key: const ValueKey('DashboardPage'),
            onConnectEarn: _navigateToConnectEarn,
            onLogout: _navigateToLogin);
      case 'connectEarn':
        return ConnectEarnPage(
            key: const ValueKey('ConnectEarnPage'),
            onBackToDashboard: _navigateToDashboard);
      default:
        return LoginPage(
            key: const ValueKey('LoginPage'), onLogin: _navigateToDashboard);
    }
  }
}
