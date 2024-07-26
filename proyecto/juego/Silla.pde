class Silla extends Gameobjetc {
  //private float velocidad;



  Silla(PVector ubicacion, PImage imagen, PVector tamaño, float velocidad) {
    super(ubicacion, imagen, tamaño);
    this.velocidad = velocidad; // Usa el parámetro pasado
  }

  @Override
  public void mover(int vertical) {
    // Puedes dejarlo vacío si no necesitas mover verticalmente la silla
  }

  @Override
  public void dibujar() {
    image(imagen, ubicacion.x, ubicacion.y, tamaño.x, tamaño.y);
  }

  
}
