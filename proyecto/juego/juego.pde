private Personaje personaje;
private Joypad joypad;





ArrayList<Gameobjetc> gameobjetcs;
PImage img_silla, img_mesa, img_armario;
Spawnerobstaculos spawner;




public void setup () {
  size(600, 600);
  // Cargar imágenes spwaner
  img_silla=loadImage("silla.png");
  img_mesa=loadImage("mesa.png");
  //img_armario=loadImage("armario.png");
  // Inicializar la lista de objetos del juego
  gameobjetcs = new ArrayList<Gameobjetc>();
  // Inicializar el spawner
  spawner = new Spawnerobstaculos(gameobjetcs, img_silla, img_mesa);//, img_armario


  PVector tamaño = new PVector(50, 90);
  PVector ubicacion = new PVector(10, height-tamaño.y);
  PImage imagen = loadImage("correr.png");
  personaje = new Personaje(ubicacion, imagen, tamaño);
  joypad= new Joypad();
}





public void draw() {
  background(0);

  int vertical=0;
  if (joypad.get_presiono_arriba()) {
    vertical=1;
  } else if (joypad.get_presiono_abajo()) {
    vertical =2;
  }

  personaje.mover(vertical);
  personaje.dibujar();

  // Dibujar el suelo
  fill(#690CED);
  rect(0, height - 25, width, 25);

  // Generar un nuevo obstáculo si es necesario
  spawner.generar_obstaculo();

  // Dibujar y mover los objetos del juego
  for (int i = gameobjetcs.size() - 1; i >= 0; i--) {
    Gameobjetc obj = gameobjetcs.get(i);
    obj.movimiento_obstaculo(); // Mueve el obstáculo a la izquierda
    obj.dibujar(); // Dibuja cada objeto

    // Reposicionar el obstáculo si sale de la pantalla
    if (obj.ubicacion.x < -obj.tamaño.x) {
      obj.ubicacion.x = width; // Reposicionar en el extremo derecho
      gameobjetcs.add(gameobjetcs.remove(i)); // Mueve el obstáculo al final de la lista
    }
  }
  
  
  
}// fin de DRAW

// metodo TECLA PRESIONDA
public void keyPressed() {
  if ( key=='w' || keyCode== UP) {
    joypad.set_presiono_arriba(true);
  }
  if ( key=='s' || keyCode== DOWN) {
    joypad.set_presiono_abajo(true);
  }
}// fin de KEYPRESSED

// metodo TECLA SIN PRESIONAR
public void keyReleased() {
  if ( key=='w' || keyCode== UP) {
    joypad.set_presiono_arriba(false);
  }
  if ( key=='s' || keyCode== DOWN) {
    joypad.set_presiono_abajo(false);
  }
}// fin de KEYPRESSED
