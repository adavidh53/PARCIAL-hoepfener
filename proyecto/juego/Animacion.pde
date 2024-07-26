class AnimacionPersonaje {
  
  
  
  
  
  private PImage[] img_corre;
  private PImage[] img_salto;
  private int indiceSprite; // Índice del sprite actual
  private int estadoActual; // Estado actual de la animación
  private int tiempoCambio; // Tiempo para cambiar el sprite
  private int tiempoUltimoCambio; // Tiempo transcurrido para el cambio de sprite

  // Estados
  public static final int ESTADO_CORRER = 0;
  public static final int ESTADO_SALTO = 1;

  AnimacionPersonaje(PImage[] img_corre, PImage[] img_salto) {
    this.img_corre = img_corre;
    this.img_salto = img_salto;
    this.indiceSprite = 0;
    this.estadoActual = ESTADO_CORRER;
    this.tiempoCambio = 150; // Tiempo en milisegundos para cambiar el sprite
    this.tiempoUltimoCambio = millis();

    // Verificar que las imágenes no sean null
    for (PImage img : img_corre) {
      if (img == null) {
        println("Error: Imagen de correr no cargada.");
      }
    }
    for (PImage img : img_salto) {
      if (img == null) {
        println("Error: Imagen de salto no cargada.");
      }
    }
  }

  public void setEstado(int nuevoEstado) {
    if (nuevoEstado != estadoActual) {
      estadoActual = nuevoEstado;
      indiceSprite = 0; // Reiniciar el índice del sprite al cambiar de estado
      tiempoUltimoCambio = millis(); // Reiniciar el tiempo de cambio
    }
  }

  public void dibujar(float x, float y, float ancho, float alto) {
    PImage[] spritesActuales;

    if (estadoActual == ESTADO_CORRER) {
      spritesActuales = img_corre;
    } else {
      spritesActuales = img_salto;
    }
    // Asegurarse de que el arreglo de sprites no esté vacío
    if (spritesActuales.length == 0) {
      println("Error: No hay sprites disponibles para dibujar.");
      return;
    }
    // Actualizar el tiempo transcurrido
    if (millis() - tiempoUltimoCambio >= tiempoCambio) {
      tiempoUltimoCambio = millis(); // Reiniciar el tiempo transcurrido
      indiceSprite = (indiceSprite + 1) % spritesActuales.length; // Cambiar al siguiente sprite
    }

    // Verificar que el índice no esté fuera de límites
    if (indiceSprite >= 0 && indiceSprite < spritesActuales.length) {
      // Asegurarse de que la imagen no es null antes de dibujar
      if (spritesActuales[indiceSprite] != null) {
        image(spritesActuales[indiceSprite], x, y, ancho, alto);
      } else {
        println("Error: Sprite actual es null.");
      }
    } else {
      println("Error: Índice de sprite fuera de límites.");
    }
  }
}
