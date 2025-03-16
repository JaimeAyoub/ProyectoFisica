class GameManager {
  float points = 0; // Puntos acumulados en el juego
  ArrayList<Bolita> bolit; // Lista de bolitas en el juego
  float SpawnBolitaPoint = 5; // Puntos necesarios para generar una nueva bolita
  boolean isOver = false; // Bandera para indicar si el juego ha terminado

  // Constructor de la clase GameManager
  GameManager(ArrayList<Bolita> bolita) {
    this.points = 0; // Inicializar los puntos en 0
    bolit = bolita; // Asignar la lista de bolitas
  }

  // Método para dibujar la puntuación en la pantalla
  void DrawScore(float textSize) {
    textSize(textSize); // Establecer el tamaño del texto
    text("Puntos: " + this.points, width/2 - 220, 20); // Dibujar el texto de los puntos
  }

  // Método para agregar puntos y modificar el comportamiento de la bolita
  void AddPoints(Bolita bol) {
    points++; // Incrementar los puntos

    // Cambiar la dirección horizontal de la bolita de manera aleatoria
    if (random(-500, 500) >= 0) {
      bol.velocity.x = 500; // Mover la bolita hacia la derecha
    } else {
      bol.velocity.x = -500; // Mover la bolita hacia la izquierda
    }
  }

  // Método principal del juego 
  void GameLoop() {
    // Verificar si alguna bolita tocó el suelo
    for (Bolita bol : bolitas) {
      if (bol.position.y >= bol.alto - bol.radius) {
        isOver = true; // Marcar el juego como terminado
      //  bol.isGroundTouched = true; // Marcar que la bolita tocó el suelo
      }
    }

    // Generar una nueva bolita si se alcanza el punto de spawn
    if (points >= SpawnBolitaPoint) {
      bolit.add(new Bolita(width, height, 20, 100, width/2, 0, 500)); // Añadir una nueva bolita
      SpawnBolitaPoint += 5; // Incrementar el punto de spawn para la siguiente bolita
    }

    // Mostrar el mensaje de "PERDISTE" si el juego ha terminado
    if (isOver) {
      textSize(50); // Establecer el tamaño del texto
      text("PERDISTE", width/2 - 220, height/2); // Dibujar el texto en el centro de la pantalla
    }
  }
}
