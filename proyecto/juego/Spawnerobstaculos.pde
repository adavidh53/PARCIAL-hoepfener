class Spawnerobstaculos {
    private ArrayList<Gameobjetc> gameobjetcs;
    private PImage img_silla, img_mesa; //, img_armario
    private float espaciado; // Distancia antes de reposicionar un obstáculo

    Spawnerobstaculos(ArrayList<Gameobjetc> gameobjetcs, PImage img_silla, PImage img_mesa) {//, PImage img_armario
        this.gameobjetcs = gameobjetcs;
        this.img_silla = img_silla;
        this.img_mesa = img_mesa;
        //this.img_armario = img_armario;
        this.espaciado = 300; // Espaciado suficiente para un solo obstáculo
    }

    public void generar_obstaculo() {
        // Generar un nuevo obstáculo si la lista está vacía o el último obstáculo está lo suficientemente lejos
        //if (gameobjetcs.isEmpty() || gameobjetcs.get(gameobjetcs.size() - 1).ubicacion.x < width - espaciado) {
          if (gameobjetcs.isEmpty() || gameobjetcs.get(gameobjetcs.size() - 1).ubicacion.x < (width+100) - espaciado) {
            crear_obstaculo();
        }
    }

    private void crear_obstaculo() {
        // Random para elegir el tipo de obstáculo
        int tipo = (int) random(2); // Selecciona un tipo de obstáculo aleatoriamente

        PVector ubicacion = new PVector(width, height - 50); // Inicializa fuera de la pantalla a la derecha
        PVector tamaño;

        switch (tipo) {
            case 0: // Silla
                tamaño = new PVector(50, 50);
                ubicacion.y = height - tamaño.y; // Aparecer en el suelo
                gameobjetcs.add(new Silla(ubicacion, img_silla, tamaño, 3)); // Añadimos velocidad
                break;
            case 1: // Mesa
                tamaño = new PVector(70, 70);
                ubicacion.y = height - tamaño.y;
                gameobjetcs.add(new Mesa(ubicacion, img_mesa, tamaño, 1)); // Añadimos velocidad
                break;
            /*case 2: // Armario
                tamaño = new PVector(90, 90);
                ubicacion.y = height - tamaño.y;
                gameobjetcs.add(new Armario(ubicacion, img_armario, tamaño, 3)); // Añadimos velocidad
                break;*/
        }
    }
}
