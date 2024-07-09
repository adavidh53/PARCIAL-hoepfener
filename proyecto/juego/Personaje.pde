class Personaje {
  private PVector ubicacion;
  private PVector velocidad;
  
  
  
  
  
  private boolean saltando;
  
  Personaje(){
   this.ubicacion= new PVector(0,0);
   this.velocidad= new PVector(0,0);
   this.saltando= false;
  }
  
  
  
  
  
  
  public void dibujar(){
    
    fill(#FF0303);
    rect(this.ubicacion.x, this.ubicacion.y, 20,60);
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
  public void set_ubicacion(PVector ubicacion){
   this.ubicacion=ubicacion; 
  }
  
   public void set_velocidad(PVector velocidad){
   this.ubicacion=ubicacion; 
  }
  
  
}// fin de PERSONAJE
