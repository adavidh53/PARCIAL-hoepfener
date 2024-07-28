class Obstaculos extends Gameobjetc {
  private int velocidad; // Velocidad específica para cada obstáculo

  Obstaculos(PVector ubicacion, PImage imagen, PVector tamaño, int velocidad) {
    super(ubicacion, imagen, tamaño);
    this.velocidad = velocidad;
  }

  // Método para mover el obstáculo
  @Override
  public void mover(int vertical) {
    // Mover el obstáculo hacia la izquierda según su velocidad
    this.ubicacion.x -= this.velocidad;

    // Reposicionar el obstáculo al final de la pantalla si sale del borde izquierdo
    if (this.ubicacion.x < -this.tamaño.x) {
      this.ubicacion.x = width + random(50, 150); // Reposicionar con un espacio aleatorio
    }
  }

  // Dibujar el obstáculo
  @Override
  public void dibujar() {
    image(imagen, ubicacion.x, ubicacion.y, tamaño.x, tamaño.y);
  }
}
