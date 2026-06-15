import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GoalDialog {
  static Future<int?> show(BuildContext context) async {
    int seleccion = 10;

    return showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),

          title: const Text(
            "Meta de repeticiones",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "¿Cuántas repeticiones desea realizar?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),

                    decoration: BoxDecoration(
                      color: Colors.black26,

                      borderRadius: BorderRadius.circular(16),

                      border: Border.all(color: AppColors.primary, width: 1.5),
                    ),

                    child: DropdownButton<int>(
                      value: seleccion,

                      dropdownColor: AppColors.card,

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),

                      underline: const SizedBox(),

                      items: [5, 10, 15, 20, 25, 30]
                          .map(
                            (e) =>
                                DropdownMenuItem(value: e, child: Text("$e")),
                          )
                          .toList(),

                      onChanged: (value) {
                        setState(() {
                          seleccion = value!;
                        });
                      },
                    ),
                  ),
                ],
              );
            },
          ),

          actions: [
            SizedBox(
              width: 160,
              height: 50,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                onPressed: () {
                  Navigator.pop(context, seleccion);
                },

                child: const Text(
                  "Aceptar",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
