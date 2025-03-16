class Player {

  float radius;
  float diameter;
  PVector position = new PVector();
  Player(float radius) {
    this.radius = radius;
    diameter = (radius *2);
  }



  void DrawPlayer()
  {
    position.x = mouseX;
    position.y = mouseY;
    
   
    fill(255);
    ellipse(mouseX, mouseY, diameter, diameter);
  }
}
