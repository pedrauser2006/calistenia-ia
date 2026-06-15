import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/exercise_controller.dart';

class ActionButtons extends StatelessWidget {
  final ExerciseController controller;

  final VoidCallback onRetry;
  final VoidCallback onContinue;

  const ActionButtons({
    super.key,
    required this.controller,
    required this.onRetry,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.esperandoConfirmacion.value &&
              !controller.cuentaRegresivaInicio.value &&
              !controller.contandoEjercicio.value
          ? Positioned(
              bottom: 20,
              right: 35,
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: onRetry,

                      icon: const Icon(Icons.refresh_rounded),

                      label: const Text(
                        "Volver a detectar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),

                        foregroundColor: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),

                        elevation: 8,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: 200,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: onContinue,

                      icon: const Icon(Icons.play_arrow_rounded),

                      label: const Text(
                        "Continuar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),

                        foregroundColor: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),

                        elevation: 8,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
