class Joypad {
 private boolean presiono_arriba;
 private boolean presiono_abajo;
 
 
 
 
 
 
 Joypad(){
  presiono_arriba=false;
  presiono_abajo=false;
   
 }
 
 
 public boolean get_presiono_arriba(){
   return this.presiono_arriba;  
 }
 
 public void set_presiono_arriba(boolean presiono_arriba){
   this.presiono_arriba=presiono_arriba;  
 }
  
 public boolean get_presiono_abajo(){
   return this.presiono_abajo;  
 }
 
 public void set_presiono_abajo(boolean presiono_abajo){
   this.presiono_abajo=presiono_abajo;  
 }
  
  
  
  
  
}// fin de Mando
