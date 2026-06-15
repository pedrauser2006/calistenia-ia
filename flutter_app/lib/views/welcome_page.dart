import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/exercise_card.dart';
import '../widgets/instructions_dialog.dart';

import '../theme/app_colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget instructionItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary),

        const SizedBox(width: 10),

        Expanded(
          child: Text(text, style: TextStyle(color: AppColors.text)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF071126), Color(0xFF0F172A)],
          ),
        ),

        child: SafeArea(
          child: FadeTransition(
            opacity: fadeAnimation,

            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    Text(
                      "CALISTENIA IA",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const SizedBox(height: 25),

                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(24),

                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.10),
                            blurRadius: 20,
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          Icon(
                            Icons.fitness_center,
                            size: 45,
                            color: AppColors.primary,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "Entrenador Inteligente",
                            style: TextStyle(
                              color: AppColors.text,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Detecta automáticamente ejercicios de calistenia mediante visión artificial y cuenta repeticiones en tiempo real.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.text),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    Text(
                      "Ejercicios disponibles",
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      crossAxisCount: 2,

                      childAspectRatio: 1.15,

                      crossAxisSpacing: 15,

                      mainAxisSpacing: 15,

                      children: [
                        const ExerciseCard(
                          icon: Icons.accessibility_new,
                          title: "SQUAT",
                          description: "Piernas y glúteos",
                        ),

                        const ExerciseCard(
                          icon: Icons.directions_run,
                          title: "LUNGE",
                          description: "Equilibrio y fuerza",
                        ),

                        const ExerciseCard(
                          icon: Icons.fitness_center,
                          title: "PUSH UP",
                          description: "Pecho y brazos",
                        ),

                        const ExerciseCard(
                          icon: Icons.sports_gymnastics,
                          title: "JUMPING JACK",
                          description: "Cardio",
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,

                          minimumSize: const Size(double.infinity, 60),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),

                        onPressed: () {
                          InstructionsDialog.show(context);
                        },

                        child: const Text(
                          "COMENZAR",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
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
