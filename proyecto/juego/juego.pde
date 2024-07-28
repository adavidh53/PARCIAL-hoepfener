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

// Variables de puntaje y tiempo
int tiempoJuego = 0;  // Tiempo total del juego en segundos
int puntaje = 0;      // Puntos obtenidos por el jugador
int limiteTiempo = 30; // Tiempo necesario para ganar el juego en segundos
boolean juegoGanado = false; // Indica si el jugador ha ganado
int tiempoInicio;     // Para controlar el inicio del cronómetro

void setup() {
  size(600, 600);

  // Cargar archivos de sonido
  sonidoSalto = new SoundFile(this, "salto.wav");
  sonidoColision = new SoundFile(this, "colision.wav");

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

  // Inicializar tiempo de inicio
  tiempoInicio = millis();
}

void draw() {
  if (!juegoTerminado && !juegoGanado) {
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

    // Reproducir sonido de salto
    if (vertical == 1 && !personaje.saltando()) {
      reproducirSonidoSalto();
    }

    personaje.dibujar();

    // Generar un nuevo obstáculo si es necesario
    spawner.generar_obstaculo();

    // Dibujar y mover los objetos del juego
    for (int i = gameobjetcs.size() - 1; i >= 0; i--) {
      Gameobjetc obj = gameobjetcs.get(i);
      obj.movimiento_obstaculo();
      obj.dibujar();

      // Verificar colisión con el personaje
      if (colision(personaje, obj)) {
        reproducirSonidoColision();
        juegoTerminado = true;
      }

      // Incrementar puntaje por esquivar obstáculo
      if (obj.ubicacion.x < -obj.tamaño.x) {
        gameobjetcs.remove(i);
        puntaje += 10;  // Incrementar puntaje por obstáculo esquivado
      }
    }

    // Actualizar el tiempo de juego y el puntaje
    int tiempoActual = millis();
    if (tiempoActual - tiempoInicio >= 1000) {  // Verifica cada segundo
      tiempoJuego++;  // Incrementa el tiempo total en segundos
      puntaje++;      // Incrementa el puntaje por cada segundo sobrevivido
      tiempoInicio = millis();  // Reinicia el tiempo de inicio
    }

    // Mostrar el tiempo y el puntaje en pantalla
    fill(0);
    textSize(20);
    text("Tiempo: " + tiempoJuego, 50, 30);
    text("Puntaje: " + puntaje, 50, 50);

    // Verificar la condición de victoria
    if (tiempoJuego >= limiteTiempo) {
      juegoGanado = true;  // Marca el juego como ganado
    }
  } else if (juegoTerminado) {
    mostrarPantallaFinJuego();  // Pantalla de fin de juego
  } else if (juegoGanado) {
    mostrarPantallaVictoria();  // Pantalla de victoria
  }
}

// Método para detectar colisiones entre el personaje y un obstáculo
boolean colision(Gameobjetc personaje, Gameobjetc obstaculo) {
  return personaje.ubicacion.x < obstaculo.ubicacion.x + obstaculo.tamaño.x &&
         personaje.ubicacion.x + personaje.tamaño.x > obstaculo.ubicacion.x &&
         personaje.ubicacion.y < obstaculo.ubicacion.y + obstaculo.tamaño.y &&
         personaje.ubicacion.y + personaje.tamaño.y > obstaculo.ubicacion.y;
}

// Método para mostrar la pantalla de fin de juego
void mostrarPantallaFinJuego() {
  background(0);
  fill(255, 0, 0);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("¡Juego Terminado!", width / 2, height / 2);
}

// Método para mostrar la pantalla de victoria
void mostrarPantallaVictoria() {
  background(0, 255, 0);  // Fondo verde para indicar victoria
  fill(255);  // Color del texto
  textSize(50);
  textAlign(CENTER, CENTER);
  text("¡Ganaste!", width / 2, height / 2);
  textSize(30);
  text("Puntuación: " + puntaje, width / 2, height / 2 + 50);
  text("Tiempo total: " + tiempoJuego + " segundos", width / 2, height / 2 + 100);
}

// Método TECLA PRESIONADA
void keyPressed() {
  if (key == 'w' || keyCode == UP) {
    joypad.set_presiono_arriba(true);
  }
  if (key == 's' || keyCode == DOWN) {
    joypad.set_presiono_abajo(true);
  }
}

// Método TECLA SIN PRESIONAR
void keyReleased() {
  if (key == 'w' || keyCode == UP) {
    joypad.set_presiono_arriba(false);
  }
  if (key == 's' || keyCode == DOWN) {
    joypad.set_presiono_abajo(false);
  }
}

// Funciones auxiliares para reproducir sonidos
void reproducirSonidoSalto() {
  if (!sonidoSalto.isPlaying()) {
    sonidoSalto.play();
  }
}

void reproducirSonidoColision() {
  if (!sonidoColision.isPlaying()) {
    sonidoColision.play();
  }
}
