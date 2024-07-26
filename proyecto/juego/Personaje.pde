class Personaje extends Gameobjetc {
  private PVector velocidad;
  private boolean saltando;
  private AnimacionPersonaje animacion; // Objeto de la clase AnimacionPersonaje

  Personaje(PVector ubicacion, PImage[] img_corre, PImage[] img_salto, PVector tamaño) {
    super(ubicacion, img_corre[0], tamaño); // Usar el primer sprite para inicializar
    this.velocidad = new PVector(0, 0);
    this.saltando = false;
    this.animacion = new AnimacionPersonaje(img_corre, img_salto); // Inicializar la animación
  }

  public void mover(int vertical) {
    switch (vertical) {
    case 1: // Si se presiona 'arriba', el personaje salta
      if (!saltando) {
        this.velocidad.y = -15; // Velocidad de salto
        this.saltando = true;
        animacion.setEstado(AnimacionPersonaje.ESTADO_SALTO); // Cambiar a estado de salto
      }
      break;
    case 2: // Si se presiona 'abajo', el personaje cae
      if (!this.saltando) {
        this.velocidad.y = 15; // Velocidad de caída
      }
      break;
    default: // Movimiento normal con gravedad
      if (this.saltando) {
        this.velocidad.y += 0.9; // Gravedad
      }
      break;
    }

    // Actualiza la posición del personaje
    this.ubicacion.x += this.velocidad.x;
    this.ubicacion.y += this.velocidad.y;

    // Limites del lienzo
    if (this.ubicacion.y > height - this.tamaño.y-25) {// Ajusta al borde inferior
      this.ubicacion.y = height - this.tamaño.y-25; // Ajusta la posición al borde inferior
      this.velocidad.y = 0; // Detiene la caída
      this.saltando = false; // Resetea el estado de salto
      animacion.setEstado(AnimacionPersonaje.ESTADO_CORRER); // Volver al estado de correr
    }

    // Si se mueve fuera del borde superior, se ajusta la posición
    if (this.ubicacion.y < 0) {
      this.ubicacion.y = 0;
    }
  }

  @Override
    public void dibujar() {
    if (animacion != null) {
      animacion.dibujar(ubicacion.x, ubicacion.y, tamaño.x, tamaño.y);
    } else {
      println("Error: animacion es null");
    }
  }
  public void set_ubicacion(PVector ubicacion) {
    this.ubicacion = ubicacion;
  }

  public PVector get_ubicacion() {
    return this.ubicacion;
  }

  public void set_velocidad(PVector velocidad) {
    this.velocidad = velocidad;
  }

  public void movimiento_obstaculo() {
    // Implementar si es necesario para el personaje
  }
}
