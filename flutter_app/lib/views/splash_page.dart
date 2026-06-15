import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import 'welcome_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 120, color: AppColors.primary),

            const SizedBox(height: 30),

            Text(
              "CALISTENIA IA",
              style: TextStyle(
                color: AppColors.text,
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Entrenador Inteligente",
              style: TextStyle(color: AppColors.text, fontSize: 18),
            ),

            const SizedBox(height: 40),

            CircularProgressIndicator(color: AppColors.primary),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
