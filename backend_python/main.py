from fastapi import FastAPI, UploadFile, File
from pydantic import BaseModel
import cv2
import mediapipe as mp
import tensorflow as tf
import numpy as np
from exercises.squat import procesar_squat, reset_squat
from exercises.lunge import procesar_lunge, reset_lunge
from exercises.pushup import procesar_pushup, reset_pushup
from exercises.jumping_jack import procesar_jumping_jack, reset_jumping_jack

interpreter = tf.lite.Interpreter(
    model_path="../models/exercise_classifier.tflite"
)

interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

classes = [
    "jumping_jack",
    "lunge",
    "pushup",
    "squat"
]

app = FastAPI()


@app.get("/")
def root():
    return {
        "mensaje": "Servidor FastAPI funcionando"
    }


@app.get("/test")
def test():
    return {
        "status": "ok"
    }

class Mensaje(BaseModel):
    texto: str


@app.post("/saludar")
def saludar(data: Mensaje):
    return {
        "respuesta": f"Hola {data.texto}"
    }

@app.post("/upload")
async def upload_image(file: UploadFile = File(...)):

    contenido = await file.read()

    with open("foto_recibida.jpg", "wb") as f:
        f.write(contenido)

    mp_pose = mp.solutions.pose

    image = cv2.imread("foto_recibida.jpg")

    rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    with mp_pose.Pose(
        static_image_mode=True,
        min_detection_confidence=0.5
    ) as pose:

        results = pose.process(rgb)

        if results.pose_landmarks:

            landmarks = []

            for lm in results.pose_landmarks.landmark:
                landmarks.append(lm.x)
                landmarks.append(lm.y)

            X = np.array(landmarks).reshape(1, 66)

            input_data = X.astype(np.float32)

            interpreter.set_tensor(
                input_details[0]['index'],
                input_data
            )

            interpreter.invoke()

            prediction = interpreter.get_tensor(
                output_details[0]['index']
            )

            detected_exercise = classes[
                np.argmax(prediction)
            ]

            print("POSE DETECTADA")
            print("EJERCICIO:", detected_exercise)

            resultado_squat = procesar_squat(
                results.pose_landmarks.landmark
            )

            print(resultado_squat)

            return {
                "ejercicio": detected_exercise
            }

        print("SIN POSE")

        return {
            "ejercicio": "sin pose",
        }

@app.post("/count_squat")
async def count_squat(file: UploadFile = File(...)):

    contenido = await file.read()

    with open("foto_recibida.jpg", "wb") as f:
        f.write(contenido)

    mp_pose = mp.solutions.pose

    image = cv2.imread("foto_recibida.jpg")

    rgb = cv2.cvtColor(
        image,
        cv2.COLOR_BGR2RGB
    )

    with mp_pose.Pose(
        static_image_mode=True,
        min_detection_confidence=0.5
    ) as pose:

        results = pose.process(rgb)

        if results.pose_landmarks:

            resultado = procesar_squat(
                results.pose_landmarks.landmark
            )

            print(resultado)

            return resultado

        return {
            "repeticiones": 0,
            "estado": "sin_pose"
        }
    
@app.post("/count_lunge")
async def count_lunge(file: UploadFile = File(...)):

    contenido = await file.read()

    with open("foto_recibida.jpg", "wb") as f:
        f.write(contenido)

    mp_pose = mp.solutions.pose

    image = cv2.imread("foto_recibida.jpg")

    rgb = cv2.cvtColor(
        image,
        cv2.COLOR_BGR2RGB
    )

    with mp_pose.Pose(
        static_image_mode=True,
        min_detection_confidence=0.5
    ) as pose:

        results = pose.process(rgb)

        if results.pose_landmarks:

            resultado = procesar_lunge(
                results.pose_landmarks.landmark
            )

            print(resultado)

            return resultado

        return {
            "repeticiones": 0,
            "estado": "sin_pose"
        }
    
@app.post("/count_pushup")
async def count_pushup(file: UploadFile = File(...)):

    contenido = await file.read()

    with open("foto_recibida.jpg", "wb") as f:
        f.write(contenido)

    mp_pose = mp.solutions.pose

    image = cv2.imread("foto_recibida.jpg")

    rgb = cv2.cvtColor(
        image,
        cv2.COLOR_BGR2RGB
    )

    with mp_pose.Pose(
        static_image_mode=True,
        min_detection_confidence=0.5
    ) as pose:

        results = pose.process(rgb)

        if results.pose_landmarks:

            resultado = procesar_pushup(
                results.pose_landmarks.landmark
            )

            print(resultado)

            return resultado

        return {
            "repeticiones": 0,
            "estado": "sin_pose"
        }
    
@app.post("/count_jumping_jack")
async def count_jumping_jack(file: UploadFile = File(...)):

    contenido = await file.read()

    with open("foto_recibida.jpg", "wb") as f:
        f.write(contenido)

    mp_pose = mp.solutions.pose

    image = cv2.imread("foto_recibida.jpg")

    rgb = cv2.cvtColor(
        image,
        cv2.COLOR_BGR2RGB
    )

    with mp_pose.Pose(
        static_image_mode=True,
        min_detection_confidence=0.5
    ) as pose:

        results = pose.process(rgb)

        if results.pose_landmarks:

            resultado = procesar_jumping_jack(
                results.pose_landmarks.landmark
            )

            print(resultado)

            return resultado

        return {
            "repeticiones": 0,
            "estado": "sin_pose"
        }
    
@app.post("/reset_counters")
def reset_counters():

    reset_squat()
    reset_lunge()
    reset_pushup()
    reset_jumping_jack()

    return {
        "mensaje": "ok"
    }