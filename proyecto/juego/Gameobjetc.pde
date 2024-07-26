abstract class Gameobjetc{
 protected PVector ubicacion;
 protected PImage imagen;
 protected PVector tamaño;
 
 
 
 
 Gameobjetc(PVector ubicacion, PImage imagen, PVector tamaño){
   this.ubicacion=ubicacion;
   this.imagen=imagen;
   this.tamaño=tamaño;
 }
 
 public abstract void mover();
 
 public abstract void dibujar();
  
  
  
}
