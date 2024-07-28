class Personaje extends Gameobjetc {
    private boolean saltando;
    private float velocidadSalto;
    private float gravedad;
    private float velocidadVertical;
    private PImage[] img_corre;
    private PImage[] img_salto;
    private int frameActual;
    private int frameSaltoActual;
    private int contadorFrames; // Nuevo contador para control de velocidad de animación
    private int contadorFramesSalto; // Nuevo contador para control de animación de salto
    private int velocidadAnimacion; 
    private int velocidadSaltoAnimacion;

    Personaje(PVector ubicacion, PImage[] img_corre, PImage[] img_salto, PVector tamaño) {
        super(ubicacion, img_corre[0], tamaño);
        this.img_corre = img_corre;
        this.img_salto = img_salto;
        this.saltando = false;
        this.velocidadSalto = -20;
        this.gravedad = 0.9;
        this.velocidadVertical = 0;
        this.frameActual = 0;
        this.frameSaltoActual = 0;
        this.contadorFrames = 0;
        this.contadorFramesSalto = 0;
        this.velocidadAnimacion = 5;  // Ajuste para hacer que la animación de correr sea más rápida
        this.velocidadSaltoAnimacion = 5;  // Ajuste para animación de salto más rápida
    }

    @Override
    public void mover(int vertical) {
        if (vertical == 1 && !saltando) {
            saltando = true;
            velocidadVertical = velocidadSalto;
        }

        if (saltando) {
            velocidadVertical += gravedad;
            ubicacion.y += velocidadVertical;

            if (ubicacion.y >= height - tamaño.y) {
                ubicacion.y = height - tamaño.y;
                saltando = false;
                velocidadVertical = 0;
                frameSaltoActual = 0;
            }
        }
    }

    @Override
    public void dibujar() {
        if (saltando) {
            if (contadorFramesSalto >= velocidadSaltoAnimacion) {
                frameSaltoActual = (frameSaltoActual + 1) % img_salto.length;
                contadorFramesSalto = 0;
            }
            contadorFramesSalto++;
            image(img_salto[frameSaltoActual], ubicacion.x, ubicacion.y, tamaño.x, tamaño.y);
        } else {
            if (contadorFrames >= velocidadAnimacion) {
                frameActual = (frameActual + 1) % img_corre.length;
                contadorFrames = 0;
            }
            contadorFrames++;
            image(img_corre[frameActual], ubicacion.x, ubicacion.y, tamaño.x, tamaño.y);
        }
    }

    public void reset() {
        ubicacion.y = height - tamaño.y;
        saltando = false;
        velocidadVertical = 0;
        frameSaltoActual = 0;
    }
}
