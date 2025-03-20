class Linea {

  PVector inicio;
  PVector fin;


  Linea(PVector inicio, PVector fin) //Funcion  basica para hacer una linea
  {
    this.inicio = inicio;
    this.fin = fin;
  }
  void DrawLine(color Color) {
    pushStyle(); //Esto es para que solo el stroke y strokeWeight afecte a las lineas de la clase linea
                  //Lo que hace la funcion es que guarda el estilo que se esta poniedno
    stroke(Color);
    strokeWeight(4);
    line(inicio.x, inicio.y, fin.x, fin.y);
    popStyle(); //Tambien se debe poner esto, ya que restaura el estilo. Al menos eso dice la pagina de processing
  }
}
