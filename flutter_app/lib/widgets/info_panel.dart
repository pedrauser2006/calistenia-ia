import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/exercise_controller.dart';

class InfoPanel extends StatelessWidget {
  final ExerciseController controller;

  const InfoPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      child: Container(
        width: 260,

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.45),

          borderRadius: BorderRadius.circular(22),

          border: Border.all(color: Colors.white24, width: 1),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Obx(
          () => Text(
            controller.esperandoConfirmacion.value
                ? (controller.cuentaRegresivaInicio.value
                      ? "Prepararse...\n${controller.tiempoInicio.value}"
                      : controller.contandoEjercicio.value
                      ? "${controller.ejercicioFinal.value.toUpperCase()}\nRepeticiones: ${controller.repeticiones.value}"
                      : "🏋️ EJERCICIO\n${controller.ejercicioFinal.value.toUpperCase()}")
                : "Ejercicio: ${controller.ejercicioActual.value}\nTiempo: ${controller.tiempoRestante.value}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}
