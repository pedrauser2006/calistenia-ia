import math

reps = 0
estado = "cerrado"


def calcular_distancia(x1, y1, x2, y2):

    return math.sqrt(
        (x2 - x1) ** 2 +
        (y2 - y1) ** 2
    )


def procesar_jumping_jack(landmarks):

    global reps
    global estado

    muneca_izq_y = landmarks[15].y
    muneca_der_y = landmarks[16].y

    nariz_y = landmarks[0].y

    tobillo_izq_x = landmarks[27].x
    tobillo_der_x = landmarks[28].x

    dist_pies = abs(
        tobillo_izq_x -
        tobillo_der_x
    )

    dist_manos = calcular_distancia(

        landmarks[15].x,
        landmarks[15].y,

        landmarks[16].x,
        landmarks[16].y
    )

    brazos_arriba = (

        muneca_izq_y < nariz_y and
        muneca_der_y < nariz_y
    )

    piernas_abiertas = (
        dist_pies > 0.12
    )

    if (
        brazos_arriba and
        piernas_abiertas
    ):

        estado = "abierto"

    if (
        not brazos_arriba and
        dist_pies < 0.08 and
        estado == "abierto"
    ):

        reps += 1
        estado = "cerrado"

    return {
        "repeticiones": reps,
        "estado": estado,
        "dist_pies": round(dist_pies, 2),
        "dist_manos": round(dist_manos, 2)
    }

def reset_jumping_jack():
    global reps
    global estado

    reps = 0
    estado = "arriba"