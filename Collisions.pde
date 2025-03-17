class Collisions {


  Collisions() {
  }

  // Método para verificar colisiones entre dos círculos
  boolean CheckColissionsCirculo(PVector position1, PVector position2, float radius1, float radius2) {
    // Calcular la diferencia en el eje X al cuadrado
    float differenceX = sq(position1.x - position2.x);
    // Calcular la diferencia en el eje Y al cuadrado
    float differenceY = sq(position1.y - position2.y);
    // Calcular la suma de los radios al cuadrado
    float differenceRadius = sq(radius1 + radius2);

    // Verificar si la distancia entre los centros es menor o igual a la suma de los radios
    if (differenceX + differenceY <= differenceRadius) {
      return true; // Hay colisión
    } else {
      return false; // No hay colisión
    }
  }

  // Método para verificar colisiones entre dos rectángulos (cuadrados)
  boolean CheckColissionsCuadrado(PVector position1, float width1, float height1, PVector position2, float width2, float height2) {
    // Verificar si los rectángulos no se superponen en el eje X o en el eje Y
    if ((position1.x + width1 < position2.x) || // Rectángulo 1 está a la izquierda de Rectángulo 2
      (position2.x + width2 < position1.x) || // Rectángulo 2 está a la izquierda de Rectángulo 1
      (position1.y + height1 < position2.y) || // Rectángulo 1 está arriba de Rectángulo 2
      (position2.y + height2 < position1.y)) { // Rectángulo 2 está arriba de Rectángulo 1
      return false; // No hay colisión
    } else {
      return true; // Hay colisión
    }
  }
  boolean CheckColissionsRecta(PVector p1, PVector p2, PVector q1, PVector q2)
  {

    PVector A = new PVector(p2.x - p1.x, p2.y - p1.y);
    PVector B = new PVector(q2.x - q1.x, q2.y - q1.y);
    PVector C = new PVector(q1.x - p1.x, q1.y - p1.y);

    float determinante = (-A.x * B.y) + (A.y * B.x);
    if (determinante == 0) return false;

    float t = (-B.y * C.x + C.y * B.x) / determinante;
    float s = (A.x * C.y - A.y * C.x) / determinante;
    return (s >= 0 && s <= 1 && t >= 0 && t <= 1);
  }

  void Momentum(Bolita b1, Bolita b2)
  {
    PVector RestaV = PVector.sub(b1.velocity, b2.velocity);
    PVector RestaR = PVector.sub(b1.position, b2.position);
    float PuntoV = PVector.dot(RestaV, RestaR);  // Producto escalar
    float NormaR2 = RestaR.magSq();  // Magnitud cuadrada del vector distancia

    if (NormaR2 != 0) {  // Evitar división por cero
      float factor1 = (2 * b2.mass) / (b1.mass + b2.mass) * (PuntoV / NormaR2);
      PVector correccion1 = RestaR.copy().mult(factor1);
      b1.velocity.sub(correccion1);

      float factor2 = (2 * b1.mass) / (b1.mass + b2.mass) * (PuntoV / NormaR2);
      PVector correccion2 = RestaR.copy().mult(factor2);
      b2.velocity.add(correccion2);
    }
  }
}
