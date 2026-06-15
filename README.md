# Calistenia IA

Proyecto de detección y conteo de ejercicios usando Flutter, FastAPI, MediaPipe y TensorFlow Lite.

---

# 1. Descargar el proyecto

Clonar el repositorio:

```bash
git clone URL_DEL_REPOSITORIO
```

---

# 2. Configurar el Backend

Entrar a:

```bash
cd backend_python
```

Crear entorno virtual:

```bash
python -m venv venv
```

Activar entorno virtual:

Windows:

```bash
venv\Scripts\activate
```

Instalar dependencias:

```bash
pip install -r requirements.txt
```

---

# 3. Ejecutar el servidor

Desde la carpeta:

```bash
backend_python
```

ejecutar:

```bash
uvicorn main:app --host 0.0.0.0 --port 8000
```

Debe aparecer algo parecido a:

```text
Uvicorn running on http://0.0.0.0:8000
```

---

# 4. Obtener la IP de la computadora

Abrir CMD y ejecutar:

```bash
ipconfig
```

Buscar:

```text
Dirección IPv4
```

Ejemplo:

```text
192.168.26.3
```

Esa IP será utilizada por Flutter.

---

# 5. Configurar Flutter

Abrir:

```text
flutter_app/lib/services/api_service.dart
```

Buscar:

```dart
Uri.parse("http://192.168.26.3:8000/upload")
```

Cambiar:

```text
192.168.26.3
```

por la IP obtenida con:

```bash
ipconfig
```

Ejemplo:

```dart
Uri.parse("http://192.168.1.50:8000/upload")
```

---

# 6. Verificar conexión

La computadora y el celular deben estar conectados a la misma red WiFi.

---

# 7. Ejecutar Flutter

Entrar a:

```bash
cd flutter_app
```

Instalar dependencias:

```bash
flutter pub get
```

Ejecutar:

```bash
flutter run
```

---

# 8. Ejercicios soportados

- Squat
- Lunge
- Pushup
- Jumping Jack

---

# Tecnologías utilizadas

- Flutter
- FastAPI
- MediaPipe
- TensorFlow Lite
- OpenCV

# Notas

Si la aplicación no detecta el servidor:

1. Verificar que FastAPI esté ejecutándose.
2. Verificar que el celular y la computadora estén en la misma red WiFi.
3. Verificar que la IP configurada en:

```text
lib/services/api_service.dart
```

coincida con la IP mostrada por:

```bash
ipconfig
```
