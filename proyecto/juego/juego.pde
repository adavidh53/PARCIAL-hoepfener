private Personaje personaje;
private Joypad joypad;





public void setup (){
  size(600, 600);
  personaje = new Personaje();
  personaje.set_ubicacion(new PVector(100, 200));
  joypad= new Joypad();
}





public void draw(){
  background(0);
  personaje.dibujar();
  
  int vertical=0;
  if(joypad.get_presiono_arriba()){
   vertical=1; 
  }else if (joypad.get_presiono_abajo()){
    vertical =2;
  }
  
  personaje.mover(vertical);
  personaje.dibujar();
    
}// fin de DRAW

// metodo TECLA PRESIONDA
public void keyPressed(){
  if ( key=='w' || keyCode== UP){
  joypad.set_presiono_arriba(true);
  }
  if ( key=='s' || keyCode== DOWN){
  joypad.set_presiono_abajo(true);
  }
  
}// fin de KEYPRESSED

// metodo TECLA SIN PRESIONAR
public void keyReleased(){
  if ( key=='w' || keyCode== UP){
  joypad.set_presiono_arriba(false);
  }
  if ( key=='s' || keyCode== DOWN){
  joypad.set_presiono_abajo(false);
  }
  
}// fin de KEYPRESSED
