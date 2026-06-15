import math

reps = 0
estado = "arriba"
ultimo_angulo_valido = 180


def calcular_angulo(ax, ay, bx, by, cx, cy):

    ba_x = ax - bx
    ba_y = ay - by

    bc_x = cx - bx
    bc_y = cy - by

    producto = ba_x * bc_x + ba_y * bc_y

    magnitud_ba = math.sqrt(
        ba_x ** 2 +
        ba_y ** 2
    )

    magnitud_bc = math.sqrt(
        bc_x ** 2 +
        bc_y ** 2
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


def procesar_lunge(landmarks):

    global reps
    global estado
    global ultimo_angulo_valido

    cadera_y = (
        landmarks[23].y +
        landmarks[24].y
    ) / 2

    pierna_visible = (

        landmarks[24].visibility > 0.7 and
        landmarks[26].visibility > 0.7 and
        landmarks[28].visibility > 0.7
    )

    angulo = calcular_angulo(

        landmarks[24].x,
        landmarks[24].y,

        landmarks[26].x,
        landmarks[26].y,

        landmarks[28].x,
        landmarks[28].y
    )

    if angulo < 30:

        angulo = ultimo_angulo_valido

    else:

        ultimo_angulo_valido = angulo

    if (
        pierna_visible and
        angulo > 30
    ):

        if (
            angulo < 100 and
            cadera_y > 0.60
        ):
            estado = "abajo"

        if (
            angulo > 140 and
            estado == "abajo"
        ):

            reps += 1
            estado = "arriba"

    return {
        "repeticiones": reps,
        "estado": estado,
        "angulo": int(angulo),
        "cadera_y": round(cadera_y, 2)
    }

def reset_lunge():
    global reps
    global estado

    reps = 0
    estado = "arriba"