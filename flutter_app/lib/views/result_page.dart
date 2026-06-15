import 'package:flutter/material.dart';
import 'welcome_page.dart';

class ResultPage extends StatelessWidget {
  final String ejercicio;
  final int repeticiones;

  const ResultPage({
    super.key,
    required this.ejercicio,
    required this.repeticiones,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      body: Center(
        child: Container(
          width: 450,

          padding: const EdgeInsets.all(35),

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),

            borderRadius: BorderRadius.circular(35),

            border: Border.all(color: Colors.white24),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Container(
                width: 120,
                height: 120,

                decoration: const BoxDecoration(
                  color: Color(0xFFFFC107),
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                  size: 70,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "¡Entrenamiento completado!",
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                ejercicio.toUpperCase(),

                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "META COMPLETADA",

                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "$repeticiones / $repeticiones",

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: 260,
                height: 65,

                child: ElevatedButton.icon(
                  icon: const Icon(Icons.home_rounded),

                  label: const Text(
                    "Volver al inicio",

                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),

                    foregroundColor: Colors.white,

                    elevation: 10,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const WelcomePage()),
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
