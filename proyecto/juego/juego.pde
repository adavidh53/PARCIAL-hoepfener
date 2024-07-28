import processing.sound.*;

// Variables globales
private Personaje personaje;
private Joypad joypad;
ArrayList<Gameobjetc> gameobjetcs;
PImage img_silla, img_mesa;
PImage[] img_corre;
PImage[] img_salto;
Spawnerobstaculos spawner;
boolean juegoTerminado; // Variable para controlar el estado del juego

// Variables de sonido
SoundFile sonidoSalto;
SoundFile sonidoColision;

public void setup() {
  size(600, 600);
  
  // Inicializar sistema de sonido
  sonidoSalto = new SoundFile(this, "salto.wav");
  sonidoColision = new SoundFile(this, "colision.wav");

  if (sonidoSalto == null) {
    println("Error al cargar el archivo de sonido: salto.wav");
  } else {
    println("Archivo de sonido salto.wav cargado correctamente.");
  }
  
  if (sonidoColision == null) {
    println("Error al cargar el archivo de sonido: colision.wav");
  } else {
    println("Archivo de sonido colision.wav cargado correctamente.");
  }

  // Cargar imágenes de los obstáculos
  img_silla = loadImage("silla.png");
  img_mesa = loadImage("mesa.png");

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
      println("Error al cargar imagen de salto: salto" + i + ".png");
    }
  }

  // Inicializar la lista de objetos del juego
  gameobjetcs = new ArrayList<Gameobjetc>();

  // Inicializar el spawner
  spawner = new Spawnerobstaculos(gameobjetcs, img_silla, img_mesa);

  // Inicializar el personaje
  PVector tamaño = new PVector(70, 110);
  PVector ubicacion = new PVector(10, height - tamaño.y);
  personaje = new Personaje(ubicacion, img_corre, img_salto, tamaño);

  // Inicializar Joypad
  joypad = new Joypad();

  // Inicializar estado del juego
  juegoTerminado = false;
}

public void draw() {
  if (!juegoTerminado) {
    background(150);

    // Determinar el estado del movimiento vertical
    int vertical = 0;
    if (joypad.get_presiono_arriba()) {
      vertical = 1;
    } else if (joypad.get_presiono_abajo()) {
      vertical = 2;
    }

    // Mover y dibujar el personaje
    personaje.mover(vertical);

    // Verificar si el personaje comienza a saltar
    if (vertical == 1 && !personaje.saltando()) {  // Comienza a saltar
      reproducirSonidoSalto();
    }

    personaje.dibujar();

    // Generar un nuevo obstáculo si es necesario
    spawner.generar_obstaculo();

    // Dibujar y mover los objetos del juego
    for (int i = gameobjetcs.size() - 1; i >= 0; i--) {
      Gameobjetc obj = gameobjetcs.get(i);
      obj.movimiento_obstaculo(); // Mueve el obstáculo a la izquierda
      obj.dibujar(); // Dibuja cada objeto

      // Verificar colisión con el personaje
      if (colision(personaje, obj)) {
        reproducirSonidoColision();
        println("¡Colisión detectada!");
        juegoTerminado = true; // Terminar el juego
      }

      // Eliminar el obstáculo si sale de la pantalla
      if (obj.ubicacion.x < -obj.tamaño.x) {
        gameobjetcs.remove(i);
      }
    }
  } else {
    mostrarPantallaFinJuego(); // Mostrar la pantalla de fin de juego
  }
}

// Método para detectar colisiones entre el personaje y un obstáculo
private boolean colision(Gameobjetc personaje, Gameobjetc obstaculo) {
  return personaje.ubicacion.x < obstaculo.ubicacion.x + obstaculo.tamaño.x &&
         personaje.ubicacion.x + personaje.tamaño.x > obstaculo.ubicacion.x &&
         personaje.ubicacion.y < obstaculo.ubicacion.y + obstaculo.tamaño.y &&
         personaje.ubicacion.y + personaje.tamaño.y > obstaculo.ubicacion.y;
}

// Método para mostrar la pantalla de fin de juego
private void mostrarPantallaFinJuego() {
  background(0);
  fill(255, 0, 0);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("¡Juego Terminado!", width / 2, height / 2);
}

// Método TECLA PRESIONADA
public void keyPressed() {
  if (key == 'w' || keyCode == UP) {
    joypad.set_presiono_arriba(true);
  }
  if (key == 's' || keyCode == DOWN) {
    joypad.set_presiono_abajo(true);
  }
}

// Método TECLA SIN PRESIONAR
public void keyReleased() {
  if (key == 'w' || keyCode == UP) {
    joypad.set_presiono_arriba(false);
  }
  if (key == 's' || keyCode == DOWN) {
    joypad.set_presiono_abajo(false);
  }
}

// Funciones auxiliares para reproducir sonidos
void reproducirSonidoSalto() {
  println("Intentando reproducir sonido de salto..."); // Mensaje de depuración
  if (!sonidoSalto.isPlaying()) {
    println("El sonido de salto no se está reproduciendo, iniciando reproducción..."); // Mensaje de depuración
    sonidoSalto.play();
    println("Reproducción de sonido de salto iniciada."); // Mensaje de depuración
  }
}

void reproducirSonidoColision() {
  println("Intentando reproducir sonido de colisión..."); // Mensaje de depuración
  if (!sonidoColision.isPlaying()) {
    sonidoColision.play();
    println("Reproducción de sonido de colisión iniciada."); // Mensaje de depuración
  }
}
