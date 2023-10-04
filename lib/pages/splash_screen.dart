import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:viacepapp/pages/welcome_page.dart';
import 'package:viacepapp/services/navigation_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  route() {
    Navigator.of(context)
        .pushReplacement(NavigationService.navigateTo(const WelcomePage()));
  }

  startTimer() {
    var duration = const Duration(milliseconds: 4500);
    return Timer(duration, route);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/lottie/splash_screen.json'),
      ),
    );
  }
}
