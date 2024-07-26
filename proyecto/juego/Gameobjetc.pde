abstract class Gameobjetc {
  protected PVector ubicacion;
  protected PImage imagen;
  protected PVector tamaño;
  protected float velocidad; // Agrega una variable de velocidad






  Gameobjetc(PVector ubicacion, PImage imagen, PVector tamaño) {
    this.ubicacion=ubicacion;
    this.imagen=imagen;
    this.tamaño=tamaño;
  }

  public abstract void mover(int vertical);

  public abstract void dibujar();


  public void movimiento_obstaculo() {
    ubicacion.x -= velocidad; // Mueve hacia la izquierda

    // Reposicionar si sale del lienzo
    if (ubicacion.x < -tamaño.x) {
      ubicacion.x = width; // Reposiciona al borde derecho
      ubicacion.y = height - tamaño.y; // Nueva posición en el borde inferior
    }
  }
}
