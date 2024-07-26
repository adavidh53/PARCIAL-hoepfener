class Personaje extends Gameobjetc {
   private PVector velocidad;
   private boolean saltando;
   
   
   
   
  
  Personaje(PVector ubicacion, PImage imagen, PVector tamaño){
   super(ubicacion, imagen, tamaño);
   this.velocidad= new PVector(0,0);
   this.saltando= false;
  }
  
  public void mover( int vertical){
    
    switch(vertical){
     case 1: {
       if(!saltando){
        this.velocidad.y=-15;
        this.saltando=true;
       }
       break;     
     }
    case 2: {
       if(!this.saltando){
        this.velocidad.y=15;
       }
       break;     
     } 
     default:{
      if(this.saltando){
        this.velocidad.y+=0.9;
     }
     break;
     }
    }// switch
    
    this.ubicacion.x+=this.velocidad.x;
    this.ubicacion.y+=this.velocidad.y;
    
    if(this.ubicacion.y>=200){
     this.ubicacion.y=200;
     this.velocidad.y=0;
     this.saltando=false;
    }
  }
  
    public void dibujar(){
    
    fill(#FF0303);
    rect(this.ubicacion.x, this.ubicacion.y, this.tamaño.x,this,tamaño.y);
  }
  
  public void set_ubicacion(PVector ubicacion){
   this.ubicacion=ubicacion; 
  }
  
   public void set_velocidad(PVector velocidad){
   this.velocidad=velocidad; 
  }
  
  
}// fin de PERSONAJE
