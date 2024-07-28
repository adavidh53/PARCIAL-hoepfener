class Spawnerobstaculos {
  private ArrayList<Gameobjetc> gameobjetcs;
  private PImage img_silla, img_mesa;
  private float espaciadoMinimo; // Espaciado mínimo entre obstáculos
  private float ultimoObstaculoX; // Posición X del último obstáculo generado
  private float multiplicadorVelocidad; // Multiplicador para la velocidad de los obstáculos

  Spawnerobstaculos(ArrayList<Gameobjetc> gameobjetcs, PImage img_silla, PImage img_mesa) {
    this.gameobjetcs = gameobjetcs;
    this.img_silla = img_silla;
    this.img_mesa = img_mesa;
    this.espaciadoMinimo = 200; // Espaciado suficiente para evitar superposición
    this.ultimoObstaculoX = -1; // Inicialización
    this.multiplicadorVelocidad = 1.5; // Inicializa el multiplicador de velocidad
  }

  public void generar_obstaculo() {
    // Generar un nuevo obstáculo si la lista está vacía o el último obstáculo está lo suficientemente lejos
    if (gameobjetcs.isEmpty() || (width - ultimoObstaculoX) > espaciadoMinimo) {
      crear_obstaculo();
    }
  }

  private void crear_obstaculo() {
    // Random para elegir el tipo de obstáculo
    int tipo = (int) random(2); // Selecciona un tipo de obstáculo aleatoriamente

    PVector ubicacion = new PVector(width, height - 70); // Inicializa fuera de la pantalla a la derecha
    PVector tamaño;
    int velocidadBase;

    if (tipo == 0) { // Silla
      tamaño = new PVector(60, 60);
      ubicacion.y = height - tamaño.y; // Aparecer en el suelo
      velocidadBase = 4; // Velocidad base de la silla
      gameobjetcs.add(new Silla(ubicacion, img_silla, tamaño, velocidadBase * multiplicadorVelocidad));
    } else if (tipo == 1) { // Mesa
      tamaño = new PVector(70, 70);
      ubicacion.y = height - tamaño.y; // Aparecer en el suelo
      velocidadBase = 5; // Velocidad base de la mesa
      gameobjetcs.add(new Mesa(ubicacion, img_mesa, tamaño, velocidadBase * multiplicadorVelocidad));
    }
    
    // Actualizar la posición X del último obstáculo generado
    ultimoObstaculoX = ubicacion.x;

    // Incrementa el multiplicador de velocidad para el próximo ciclo
    multiplicadorVelocidad += 0.001; // Aumenta lentamente el multiplicador
  }
}
