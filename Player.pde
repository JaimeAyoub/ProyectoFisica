class Player {

  float radius;
  float diameter;
  PVector position = new PVector();
  Player(float radius) {
    this.radius = radius;
    diameter = (radius *2);
  }



  void DrawPlayer(color _color)
  {
    position.x = mouseX;
    position.y = mouseY;
    
   
    fill(_color);
    ellipse(mouseX, mouseY, diameter, diameter);
  }
}
