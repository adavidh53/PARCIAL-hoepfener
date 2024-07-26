class Obstaculos extends Gameobjetc {




  Obstaculos(PVector ubicacion, PImage imagen, PVector tamaño, int velocidad) {
    super(ubicacion, imagen, tamaño);
    this.velocidad=velocidad;
  }//construtor

  @Override
    public void mover(int vertical) {
    // Implementar si es necesario para obstáculos.
  }

  @Override
    public void dibujar() {
    image(imagen, ubicacion.x, ubicacion.y, tamaño.x, tamaño.y);
  }

  
}
