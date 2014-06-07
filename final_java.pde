import java.util.*;
  
    Tile[][]map;
    
    color brown = color(101,67,33);
    
    boolean moving = false;   
  
   
  color red =  color(245,20,20);

  
void setup(){
     size(400,400);
    frameRate(25);  
    
     map = new Tile[20][20];
  
    for (int i = 0; i < map.length; i++){
       for (int j = 0; j < map[0].length; j++){
          addTile(i,j,brown);
       } 
    }
}
  
void draw(){
   background(300);
   for (int i = 0; i < map.length; i ++){
    for (int j = 0; j < map[0].length; j++){
        Tile t = map[i][j];
        t.display((20 * i),(20 + j));
    } 
   }
}

class Tile{
   private int x, y;
   private color c; 
   private boolean occupied;
   
    public Tile(int r, int c, color co){
       x = r;
       y = c;
       this.c = co;
        occupied = false; 
    }
    
    public void display(){
     fill(c);
    rect(x,y,20,20); 
    }
    
    public void display(int x, int y){
     fill(c);
      rect( x,y,20,20);
    }
   
public color getColor(){
   return c; 
}
}
public void addTile(int r, int c, color co){
  map[r][c] = new Tile(r,c,co); 
}

