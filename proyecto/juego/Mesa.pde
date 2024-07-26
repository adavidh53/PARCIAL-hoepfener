class Mesa extends Gameobjetc {
  //private float velocidad;

  Mesa(PVector ubicacion, PImage imagen, PVector tamaño, float velocidad) {
    super(ubicacion, imagen, tamaño);
    this.velocidad = velocidad;
  }

  @Override
    public void mover(int vertical) {
    // Implementa el movimiento de la mesa si es necesario
    ubicacion.x -= velocidad;
  }

  @Override
    public void dibujar() {
    // Dibuja la mesa en el lienzo
    image(imagen, ubicacion.x, ubicacion.y, tamaño.x, tamaño.y);
  }
}
