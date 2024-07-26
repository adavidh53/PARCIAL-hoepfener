private Personaje personaje;
private Joypad joypad;





ArrayList<Gameobjetc> gameobjetcs;
PImage img_silla, img_mesa;
PImage[] img_corre;
PImage[] img_salto;
Spawnerobstaculos spawner;




public void setup () {
  size(600, 600);
  // Cargar imágenes spwaner
  img_silla=loadImage("silla.png");
  img_mesa=loadImage("mesa.png");
  
  // Cargar sprites para correr
  img_corre = new PImage[5];
  for (int i = 0; i < img_corre.length; i++) {
    img_corre[i] = loadImage("correr" + i + ".png");
    if (img_corre[i] == null) {
      println("Error al cargar imagen de correr: corre" + i + ".png");
    }
  }

  // Cargar sprites para saltar
  img_salto = new PImage[5];
  for (int i = 0; i < img_salto.length; i++) {
    img_salto[i] = loadImage("salto" + i + ".png");
    if (img_salto[i] == null) {
      println("Error al cargar salto" + i + ".png");
    } else {
      println("Imagen salto" + i + ".png cargada correctamente");
    }
  }

  // Inicializar la lista de objetos del juego
  gameobjetcs = new ArrayList<Gameobjetc>();
  // Inicializar el spawner
  spawner = new Spawnerobstaculos(gameobjetcs, img_silla, img_mesa);

  //Inicializar el personaje
  PVector tamaño = new PVector(60, 110);
  PVector ubicacion = new PVector(10, height-tamaño.y);
  personaje = new Personaje(ubicacion, img_corre, img_salto, tamaño);
  //Inicializar Joypad
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
