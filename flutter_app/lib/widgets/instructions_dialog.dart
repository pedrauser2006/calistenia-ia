import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../views/home_page.dart';

class InstructionsDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),

          title: Text(
            "Instrucciones",
            textAlign: TextAlign.center,

            style: TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.bold,
            ),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              _instructionItem(
                Icons.screen_rotation,
                "Coloca el teléfono en horizontal",
              ),

              const SizedBox(height: 10),

              _instructionItem(
                Icons.accessibility_new,
                "Mantén todo tu cuerpo visible",
              ),

              const SizedBox(height: 10),

              _instructionItem(Icons.light_mode, "Utiliza buena iluminación"),

              const SizedBox(height: 10),

              _instructionItem(
                Icons.fitness_center,
                "Realiza el ejercicio de forma natural",
              ),
            ],
          ),

          actionsAlignment: MainAxisAlignment.spaceBetween,

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
              child: const Text("Empezar"),
            ),
          ],
        );
      },
    );
  }

  static Widget _instructionItem(IconData icon, String text) {
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
}
