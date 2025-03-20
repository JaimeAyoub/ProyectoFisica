//Hola, bienvenidos a "B A L L S"
//Tienes un solo objetivo, evitar que la bola caiga al piso, si lo hace pues perdiste.
//Perdon, dije la bola? jaja perdon, eso seria demasiado facil, mas bien seran LAS bolas.
//Asi es, cada 5 puntos una nueva bola aparecera, para hacer este juego un poco mas dificil.
//Para evitar que toquen el suelo tienes una sola herramienta, un circulo que siempre estara en la posicion de tu mouse.
//da click cuando tu circulo este colisionando con las bolas para hacer que reboten hacia arriba.



//Declaracion de clases.//
PVector posRecta1 = new PVector();
PVector posRecta2 = new PVector();
PVector posRecta3 = new PVector();
PVector posRecta4 = new PVector();
Linea linea;
Player player;        //Hacemos el jugador, el cual es el circulo que se crea en la posicion del mouse.
Cuadrados cuadrado1;  //Hacemos uno de los dos cuadrados, tanto este como el otro solo van a servir para poder demostrar la colision de bounding boxes.
Cuadrados cuadrado2;//Hacemos el otro cuadrado.
Bolita bolMovimientoC;
Bolita bolMovimientoC2;

Bolita centro;
Bolita gira;
Bolita gira2;
public ArrayList <Bolita> bolitas = new ArrayList<Bolita>(); //Creamos nuestro arraylist de bolitas que iran apareciendo en la pantalla.
Collisions colisiones; //Tambien hacemos nuestra referencia a nuestra clase de colisiones, que se encargara pues de detectar las colisiones entre circulos y cuadrados.
GameManager GM;  //Y nuestro game manager, el cual se encargara de ir sumando puntos, y ver cuando el jugador a perdido.
//-----------------------------------//
//Declaracion de variables//

//Variables para el click//
boolean isClicked ;

long mousePressTime = 0; //Guardar el tiempo en el que presionamos el mouse.
long mouseReleaseTime = 0; //Guardar el tiempo de cuando se deja de presionar el mouse

float clickTimer = 0; //Estos timer nos ayudaran a setear nuestro isClicked devuelta a falso
float clickDuration = 5;
float CLICK_THRESHOLD = 200; // Umbral para cuando comparemos el tiempo de presionado y de levantamiento? de mouse.
//---------------------//

float dt = 0;  //Para calcular nuestro delta time
color ColorBolita1; //Este valor y el de abajo nos servira para cambiarles el color a las cosas que tengan colisiones.
color ColorCuad;
color ColorPlayer;
color colisionR;
//Variables para movimiento Circular
float acelerationAng = 2.0f;
float angleUniforme;
float angleConst;
float angleVelocity;

void setup()
{
  size(1920, 1080); //Tamalo de nuestra ventana
  posRecta1.x =0;
  posRecta1.y =0;
  posRecta3.x = width;
  posRecta3.y = 0;

  centro = new Bolita(width, height, 50, 50, 150, 150, 20);
  gira = new Bolita(width, height, 50, 20, 100, 100, 20);
  gira2 = new Bolita(width, height, 50, 10, 100, 100, 20);

  colisiones = new Collisions(); //Creamos nuestra colsion
  bolitas.add(new Bolita(width, height, 1000, 50, width/2, height/2, 200)); //Creamos la primera bolita del array de bolitas, su constructor es: ancho,alto, radio, masa ,
  // y posicion en x y Y en donde quieres que aparezca la bolita.

  cuadrado1 = new Cuadrados( 20, 20);  //Constructor de nuestros cuadrados, estos reciben el ancho y alto que queramos del cuadrado.
  cuadrado2= new Cuadrados(20, 20);
  player = new Player(50);            //Creamos nuestro player, el constructor solo recibe el radio que quieres que tenga el circulo del mouse.
  GM = new GameManager(bolitas);       //Creamos nuestro game manager, el cual recibe nuestro array de bolitas.
}

void draw()
{

  posRecta2.x = mouseX;
  posRecta2.y = mouseY;
  posRecta4.x = mouseX ;
  posRecta4.y = mouseY - 150;  //
  float t=millis();
  float frames = int( abs( -90*sin(0.0000001*t) + 10*sin(0.000002*t) + 20*sin(0.00002*t) - 20*cos(0.0003*t) )) + 10;
  frameRate(frames);    //Establecemos el framerate para que vaya variando en funcion del tiempo.
  dt = 1.0/frames;      //Calculamos el delta time
  background(255);      // Fondo blanco






  GM.GameLoop();        //Llamamos nuestro GameLoop, el cual se encarga de que cuando una bola toque el suelo, pierda
  GM.DrawScore(20);    //Llamamos nuestra funcion de escribir el score, este recibe el tamaño del texto que uno desee.
  if (isClicked)
  {

    ColorPlayer =  color (0, 0, 0);
  } else
  {
    ColorPlayer =  color (255, 255, 255);
  }

  player.DrawPlayer(ColorPlayer);  //Dibujamos a nuestro jugador.

  for (Bolita bol : bolitas ) //For each para recorrer nuestro arraylist de bolitas
  {
    if (colisiones.CheckColissionsCirculo(bol.position, player.position, player.radius, bol.radius) &&
      isClicked && !GM.isOver ) //Checamos si alguna de las bolitas es clickeada por nuestro jugador.
    {
      bol.Jump();

      ColorBolita1 = color(random(255), random(255), random(255)); //Cuando una bolita es clickeada, esta cambia su color a uno aleatorio.

      GM.AddPoints(bol); //Sumamos un punto.
    }
  }
  for (int i = 0; i < bolitas.size(); i++) //Necesitamos 2 fors para poder checar las colisiones entre las bolas del array de bolitas
  {
    Bolita b1 = bolitas.get(i);
    for (int j = i +1; j<bolitas.size(); j++)
    {
      Bolita b2 = bolitas.get(j);
      if (colisiones.CheckColissionsCirculo(b1.position, b2.position, b1.radius, b2.radius))
      {
        colisiones.Momentum(b1, b2);
      }
    }
  }

  if (colisiones.CheckColissionsCuadrado(cuadrado1.position, cuadrado1.ancho, cuadrado1.alto,
    cuadrado2.position, cuadrado2.ancho, cuadrado2.alto)) //Checamos si los cuadrados colisionan, si es el caso,
    //Al igual que las bolitas, estos cambian de color,
    //solo que cuando no lo hacen, vuelven a su color original.
  {
    ColorCuad = color(215, 145, 1);
  } else
  {
    ColorCuad = color(255, 255, 255);
  }




  centro.DrawBolita(ColorBolita1);  //Bola grande, esta quedara estatica
  gira.DrawBolita(ColorBolita1);  //Bolita chiquita que girara alrededor de la bolita "centro" de forma uniforme
  gira2.DrawBolita(ColorBolita1); // Igual que la anterior, pero esta girara de manera constante

  angleVelocity +=  acelerationAng * dt; //Le vamos sumando a nuestra velocidad que cambia nuestro angulo la aceleracion.
  angleVelocity = constrain(angleVelocity, 0, 25); //Limitamos la velocidad.
  angleUniforme -= angleVelocity * dt; // Se usa el -= para que gire en sentido contrario de las manecillas del reloj

  gira.MovimientoCircular( centro.position, angleUniforme, 100);
  gira2.MovimientoCircular( centro.position, angleConst -= 1f *dt, 100);//Llamamos a la funcion en la bolita gira, para que gire con respecto a centro

  cuadrado1.DrawCuadrado(mouseX, mouseY, ColorCuad); //Uno de los cuadrados igual se dibujara en la posicion del mouse.


  cuadrado2.DrawCuadrado(500, 400, ColorCuad);  //El otro solo esta en esa posicion.
  for (Bolita bol : bolitas )  //For each para dibujar cada bolita y su funcion de fisicas.
  {
    bol.PhysicsBolita(dt);

    bol.DrawBolita(ColorBolita1);
  }

  if (clickTimer > 0) {  //Timer que como dije antes, vuelve a setear nuestro boleano de isClicked a falso
    clickTimer--;
  } else {
    isClicked = false;
  }
}
//}
void mousePressed() {  //Funcion de processing que registra cuando el mouse esta siendo presionado
  mousePressTime = millis();
  //angle += 0.10;
}

void mouseReleased() {  //Funcion de processing que registra cuando el mouse ya no esta siendo presionado
  mouseReleaseTime = millis();
  if (mouseReleaseTime - mousePressTime < CLICK_THRESHOLD) {  //Restamos nuestas dos variables del mouse y si este es menor a nuestro umbral,
    //es como si hubiera sido un click. en el PDF explico porque se hizo esto.
    isClicked = true;
  }
}
