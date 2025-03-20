class Bolita {
  // Medidas de nuestra bolita
  float radius;  // Radio de la bolita
  float diameter;  // Diámetro de la bolita (radio * 2)

  // Aquí guardamos la posición, velocidad y aceleración de la bolita usando PVector.
  PVector position = new PVector();  // Posición en el espacio 2D (x, y)
  PVector velocity = new PVector();  // Velocidad en los ejes x e y
  PVector acceleration = new PVector();  // Aceleración en los ejes x e y

  // Variables para físicas
  float gravity = 9.81*100/(60*60 );  // Gravedad convertida a pixeles, en donde 100 px equivale a 1 metro, 60 es por fps,se quizo usar el frameRate, pero hacia le juego injugable
  float ForceY;  // Fuerza en el eje Y (calculada como masa * gravedad)
  float mass;  // Masa de la bolita
  float maxSpeedX = 500;  // Velocidad máxima en el eje X
  float maxSpeedY = 1000;  // Velocidad máxima en el eje Y
  float jumpForce = 300;  // Fuerza de salto aplicada en el eje Y
  // Tamaño de la pantalla y delta Time
  float ancho, alto;  // Ancho y alto de la pantalla

  boolean isGroundTouched = false;  // Bandera para verificar si la bolita tocó el suelo

  // Constructor de la clase Bolita
  Bolita(float w, float h, float mass, float radius, float posX, float posY, float ForceX) {
    ancho = w;  // Ancho de la pantalla
    alto = h;  // Alto de la pantalla
    this.radius = radius;  // Asignar el radio de la bolita
    this.mass = mass;  // Asignar la masa de la bolita
    diameter = (radius * 2);  // Calcular el diámetro
    position.x = posX;  // Posición inicial en X
    position.y = posY;  // Posición inicial en Y
    ForceY = mass * gravity;  // Calcular la fuerza en Y usando la fórmula de tiro parabólico

    acceleration.y = ForceY;  // Asignar la aceleración en Y
    acceleration.x = ForceX / mass;  // Calcular la aceleración en X usando la fórmula de MRUA
  }

  // Método para dibujar la bolita en la pantalla
  void DrawBolita(color _color) {
    fill(_color);  // Establecer el color de relleno
    ellipse(position.x, position.y, diameter, diameter);  // Dibujar la bolita como una elipse
  }

  // Método para aplicar físicas a la bolita
  void PhysicsBolita(float dt) {
    // Actualizar la velocidad en Y y X usando la aceleración y el delta time (dt)

    velocity.y += acceleration.y * dt;
    velocity.x += acceleration.x * dt;

    // Limitar la velocidad en X e Y para que no supere los valores máximos
    velocity.x = constrain(velocity.x, -maxSpeedX, maxSpeedX);
    velocity.y = constrain(velocity.y, -maxSpeedY, maxSpeedY);

    // Actualizar la posición en X e Y usando la velocidad y el delta time (dt)
    position.x += velocity.x * dt;
    position.y += velocity.y * dt;

    // Verificar si la bolita toca el suelo
    if (position.y >= alto - radius) {
      isGroundTouched = true;  // Marcar que tocó el suelo
      position.y = alto - radius;  // Asegurar que la bolita no pase del suelo
      velocity.y = 0;  // Detener la velocidad en Y
    }

    // Verificar si la bolita toca los bordes laterales de la pantalla
    if (position.x >= ancho - radius - 20 || position.x <= 0 + radius) {
      velocity.x *= -1;  // Invertir la velocidad en X para que rebote
    }
  }

  // Método para hacer que la bolita salte
  void Jump() {

    velocity.y = -jumpForce;  // Aplicar una fuerza negativa en Y para simular el salto
  }

  void MovimientoCircular(PVector center, float angle, float radius) { //Funcion para movimiento Circular
                                                                       //el center es el del objeto en donde se quiere obtener el movimiento alrededor de el
    position.x = center.x + cos(angle) * radius;
    position.y = center.y + sin(angle) * radius;
  }
}
