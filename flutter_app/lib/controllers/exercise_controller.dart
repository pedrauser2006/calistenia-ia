import 'package:get/get.dart';

class ExerciseController extends GetxController {
  var tiempoRestante = 10.obs;

  var ejercicioActual = "Detectando...".obs;

  var ejercicioFinal = "".obs;

  var esperandoConfirmacion = false.obs;

  var cuentaRegresivaInicio = false.obs;

  var tiempoInicio = 5.obs;

  var repeticiones = 0.obs;

  var objetivoRepeticiones = 10.obs;

  var estadoEjercicio = "".obs;

  var contandoEjercicio = false.obs;
}
