import math

reps = 0
estado = "arriba"


def calcular_angulo(ax, ay, bx, by, cx, cy):

    ba_x = ax - bx
    ba_y = ay - by

    bc_x = cx - bx
    bc_y = cy - by

    producto = ba_x * bc_x + ba_y * bc_y

    magnitud_ba = math.sqrt(
        ba_x ** 2 + ba_y ** 2
    )

    magnitud_bc = math.sqrt(
        bc_x ** 2 + bc_y ** 2
    )

    coseno = producto / (
        magnitud_ba * magnitud_bc
    )

    coseno = max(
        -1,
        min(1, coseno)
    )

    return math.degrees(
        math.acos(coseno)
    )


def procesar_squat(landmarks):

    global reps
    global estado

    cadera_y = (
        landmarks[23].y +
        landmarks[24].y
    ) / 2

    piernas_visible = (

        landmarks[23].visibility > 0.7 and
        landmarks[25].visibility > 0.7 and
        landmarks[27].visibility > 0.7
    )

    angulo_izq = calcular_angulo(

        landmarks[23].x,
        landmarks[23].y,

        landmarks[25].x,
        landmarks[25].y,

        landmarks[27].x,
        landmarks[27].y
    )

    angulo_der = calcular_angulo(

        landmarks[24].x,
        landmarks[24].y,

        landmarks[26].x,
        landmarks[26].y,

        landmarks[28].x,
        landmarks[28].y
    )

    if piernas_visible:

        if (
            angulo_izq < 110 and
            angulo_der < 110 and
            cadera_y > 0.65
        ):
            estado = "abajo"

        if (
            angulo_izq > 150 and
            angulo_der > 150 and
            estado == "abajo"
        ):
            reps += 1
            estado = "arriba"

    return {
        "repeticiones": reps,
        "estado": estado,
        "angulo_izq": int(angulo_izq),
        "angulo_der": int(angulo_der)
    }

def reset_squat():
    global reps
    global estado

    reps = 0
    estado = "arriba"