import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ExerciseCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ExerciseCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),

      decoration: BoxDecoration(
        color: AppColors.card,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(icon, color: AppColors.primary, size: 50),

          const SizedBox(height: 12),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.text,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.text.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
