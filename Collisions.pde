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
}
