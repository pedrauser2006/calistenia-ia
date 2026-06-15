import 'dart:async';
import 'result_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tercer_parcial/widgets/top_status_bar.dart';
import '../widgets/info_panel.dart';
import '../widgets/action_buttons.dart';
import '../controllers/exercise_controller.dart';
import '../services/api_service.dart';
import '../widgets/goal_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final exerciseController = Get.put(ExerciseController());
  final apiService = ApiService();

  CameraController? controller;
  List<String> ejerciciosDetectados = [];
  bool procesando = false;
  int totalDetecciones = 0;
  String estadoEjercicio = "";
  bool resultadoMostrado = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    iniciarCamara();
  }

  Future<void> iniciarCamara() async {
    final cameras = await availableCameras();

    controller = CameraController(
      cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      ),
      ResolutionPreset.high,
    );

    await controller!.initialize();

    iniciarTemporizador();

    setState(() {});
  }

  Future<void> detectarEjercicio() async {
    if (procesando) return;

    procesando = true;

    try {
      final XFile foto = await controller!.takePicture();

      final ejercicio = await apiService.detectarEjercicio(foto.path);

      if (ejercicio != null) {
        ejerciciosDetectados.add(ejercicio);

        exerciseController.ejercicioActual.value = ejercicio;
      }
    } catch (e) {
      print(e);
    }

    procesando = false;
  }

  Future<void> contarEjercicio() async {
    if (procesando) return;

    procesando = true;

    try {
      final XFile foto = await controller!.takePicture();

      String endpoint = "/count_squat";

      if (exerciseController.ejercicioFinal.value == "lunge") {
        endpoint = "/count_lunge";
      }

      if (exerciseController.ejercicioFinal.value == "pushup") {
        endpoint = "/count_pushup";
      }

      if (exerciseController.ejercicioFinal.value == "jumping_jack") {
        endpoint = "/count_jumping_jack";
      }

      final data = await apiService.contarEjercicio(foto.path, endpoint);

      if (data != null) {
        exerciseController.repeticiones.value = data["repeticiones"];

        estadoEjercicio = data["estado"];

        if (exerciseController.repeticiones.value >=
            exerciseController.objetivoRepeticiones.value) {
          exerciseController.contandoEjercicio.value = false;

          if (!resultadoMostrado) {
            resultadoMostrado = true;

            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => ResultPage(
                    ejercicio: exerciseController.ejercicioFinal.value,

                    repeticiones: exerciseController.repeticiones.value,
                  ),
                ),
              );
            });
          }

          return;
        }
      }
    } catch (e) {
      print(e);
    }

    procesando = false;
  }

  String obtenerEjercicioDominante() {
    if (ejerciciosDetectados.isEmpty) {
      return "desconocido";
    }

    Map<String, int> conteo = {};

    for (String ejercicio in ejerciciosDetectados) {
      conteo[ejercicio] = (conteo[ejercicio] ?? 0) + 1;
    }

    String dominante = conteo.keys.first;

    conteo.forEach((ejercicio, cantidad) {
      if (cantidad > conteo[dominante]!) {
        dominante = ejercicio;
      }
    });

    return dominante;
  }

  void iniciarCuentaRegresivaInicio() {
    exerciseController.cuentaRegresivaInicio.value = true;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (exerciseController.tiempoInicio.value > 0) {
        exerciseController.tiempoInicio.value--;
      } else {
        timer.cancel();

        exerciseController.cuentaRegresivaInicio.value = false;

        if (exerciseController.ejercicioFinal.value == "squat" ||
            exerciseController.ejercicioFinal.value == "lunge" ||
            exerciseController.ejercicioFinal.value == "pushup" ||
            exerciseController.ejercicioFinal.value == "jumping_jack") {
          exerciseController.contandoEjercicio.value = true;

          Timer.periodic(const Duration(milliseconds: 150), (timer) async {
            if (!exerciseController.contandoEjercicio.value) {
              timer.cancel();
              return;
            }

            await contarEjercicio();
          });
        }
      }
    });
  }

  void iniciarTemporizador() {
    Timer.periodic(const Duration(milliseconds: 250), (timer) async {
      if (exerciseController.tiempoRestante.value <= 0) {
        timer.cancel();

        exerciseController.ejercicioFinal.value = obtenerEjercicioDominante();

        exerciseController.esperandoConfirmacion.value = true;

        return;
      }

      await detectarEjercicio();

      totalDetecciones++;

      if (totalDetecciones % 4 == 0) {
        exerciseController.tiempoRestante.value--;
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(child: CameraPreview(controller!)),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.35),
                  Colors.transparent,
                  Colors.black.withOpacity(0.55),
                ],
              ),
            ),
          ),

          const TopStatusBar(),

          InfoPanel(controller: exerciseController),

          ActionButtons(
            controller: exerciseController,

            onRetry: () {
              ejerciciosDetectados.clear();

              exerciseController.ejercicioFinal.value = "";

              exerciseController.ejercicioActual.value = "Detectando...";

              exerciseController.tiempoRestante.value = 10;

              exerciseController.tiempoInicio.value = 5;

              exerciseController.contandoEjercicio.value = false;

              totalDetecciones = 0;

              exerciseController.esperandoConfirmacion.value = false;

              exerciseController.repeticiones.value = 0;

              exerciseController.objetivoRepeticiones.value = 10;

              exerciseController.estadoEjercicio.value = "";

              resultadoMostrado = false;

              iniciarTemporizador();
            },

            onContinue: () async {
              final meta = await GoalDialog.show(context);

              if (meta == null) return;

              exerciseController.objetivoRepeticiones.value = meta;

              iniciarCuentaRegresivaInicio();
            },
          ),
        ],
      ),
    );
  }
}
