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


def procesar_pushup(landmarks):

    global reps
    global estado
    global ultimo_angulo_valido

    hombro_y = landmarks[12].y
    cadera_y = landmarks[24].y

    angulo = calcular_angulo(

        landmarks[12].x,
        landmarks[12].y,

        landmarks[14].x,
        landmarks[14].y,

        landmarks[16].x,
        landmarks[16].y
    )

    if angulo < 30:

        angulo = ultimo_angulo_valido

    else:

        ultimo_angulo_valido = angulo

    brazo_visible = (

        landmarks[12].visibility > 0.7 and
        landmarks[14].visibility > 0.7 and
        landmarks[16].visibility > 0.7
    )

    if brazo_visible:

        if (
            angulo < 147 and
            hombro_y > 0.57
        ):

            estado = "abajo"

        elif (
            angulo > 155 and
            hombro_y < 0.55
        ):

            if estado == "abajo":

                reps += 1

            estado = "arriba"

    return {
        "repeticiones": reps,
        "estado": estado,
        "angulo": int(angulo),
        "hombro_y": round(hombro_y, 2),
        "cadera_y": round(cadera_y, 2)
    }

def reset_pushup():
    global reps
    global estado

    reps = 0
    estado = "arriba"