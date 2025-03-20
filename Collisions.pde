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
  boolean CheckColissionsRecta(Linea r1, Linea r2) //Funcion para colisiones de rectas
  {
    PVector p1 = r1.inicio;//Sacamos los puntos de inicio de nuestra linea 1
    PVector p2 = r1.fin;   //Sacamos los puntos del final de nuestra linea 1
    PVector q1 = r2.inicio;//Igual con la linea 2
    PVector q2 = r2.fin;
    PVector A = new PVector(p2.x - p1.x, p2.y - p1.y); //Empezamos a hacer nuestros vectores que necesitan nuestra formula
    PVector B = new PVector(q2.x - q1.x, q2.y - q1.y);
    PVector C = new PVector(q1.x - p1.x, q1.y - p1.y);

    float determinante = (-A.x * B.y) + (A.y * B.x); //Sacamos de una vez nuestro determinante
    if (determinante == 0) return false; //Ya que es pecado capital dividir entre 0, si se da el caso, regresamos falso
    //Aunque sabemos que si da 0 es por diferentes casos, como que las rectas sean paralelas

    float t = (-B.y * C.x + C.y * B.x) / determinante; //sacamos T
    float s = (A.x * C.y - A.y * C.x) / determinante;  //sacamos S
    return (s >= 0 && s <= 1 && t >= 0 && t <= 1); //y como se nos dijo en clase, si t o s es mayor que 1,
    //Significa que no hay colision.
  }

  void Momentum(Bolita b1, Bolita b2) //Funcion para formula de conservacion de movimiento
  {
    //Empezamos a hacer nuestras operaciones de vectores, al menos para V1
    PVector RestaV = PVector.sub(b1.velocity, b2.velocity); //Nuestra resta de vectores v1 - v2

    PVector RestaR = PVector.sub(b1.position, b2.position); //Resta de posiciones r1 - r2

    float PuntoV = PVector.dot(RestaV, RestaR);  // Producto escalar
    float NormaR2 = RestaR.magSq();  // Magnitud cuadrada del vector distancia
    //magSq nos permite calcular la magnitud de un vector al cuadrado
    
    //Operaciones para V2
    PVector RestaV2 = PVector.sub(b2.velocity, b1.velocity);
    PVector RestaR2 = PVector.sub(b2.position, b1.position);
    float PuntoV2 = PVector.dot(RestaV2, RestaR2);
    float NormaR2V = RestaR2.magSq();
    
    

    if (NormaR2 != 0) {  // Evitar división por cero
      float factor1 = (2 * b2.mass) / (b1.mass + b2.mass) * (PuntoV / NormaR2); //Con lo obtenido anteriormente multiplicamos
      PVector correccion1 = RestaR.copy().mult(factor1); //usamos el copy, esto hace una copia del vector que estamos restando sin afectar al original
      b1.velocity.sub(correccion1);//Por ultimo le restamos al vector velocidad 1 todo lo anterior

      float factor2 = (2 * b1.mass) / (b1.mass + b2.mass) * (PuntoV2 / NormaR2V); //Esto es casi lo mismo, solo que se cambia la masa de arriba y usamos las otras operaciones.
      PVector correccion2 = RestaR2.copy().mult(factor2);
      b2.velocity.sub(correccion2);
    }
  }
}
