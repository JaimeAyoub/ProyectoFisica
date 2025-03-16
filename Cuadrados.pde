class Cuadrados
{

  PVector position = new PVector();

  float ancho, alto;
  Cuadrados( float ancho, float alto)
  {

    this.ancho = ancho;
    this.alto = alto;
  }

  void DrawCuadrado(float posX, float posY, color Color)
  {
    position.x = posX;
    position.y = posY;
    fill(Color);
    rect(position.x, position.y, ancho, alto);
  }
}
