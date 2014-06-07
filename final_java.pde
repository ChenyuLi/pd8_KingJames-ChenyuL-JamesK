import java.util.*;
  
    final static int NORTH = 1;
    final static int EAST = 2;
    final static int SOUTH = 3;
    final static int WEST = 4;
  
    Tile[][]map;
    
    color brown = color(101,67,33);
    
    boolean moving = false;   
  
    Player ash;
    
  color red =  color(245,20,20);

  
void setup(){
     size(400,400);
    frameRate(25);  
    
     map = new Tile[20][20];
  
  ash = new Player();
  
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
        t.display();
    } 
   }
   
   ash.display();
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
    rect(x * 20,y * 20,20,20); 
    }
   
public color getColor(){
   return c; 
}
}
class Player{
 private int x,y,direction;
 //direction is an int cause it's easier for me.
 //1 north 2 east 3 south 4 west
 
 //until I get a real image
 private color c;
 
 public Player(){
  x = 2;
  y = 16;
  c = red;
  direction = NORTH;
 }
 
 public void display(){
    fill(c);
     rect(x * 20, y * 20, 20, 20);
 }

 public void moveLeft(){
  if (x > 0){
   x--;
   direction = 4;
  } 
 }
 public void moveRight(){
  if (x< 19){
   x--;
   direction = 2;
}
 }
 
 public void moveUp(){
  if (y< 0){
   y++;
   direction = 1;
  } 
 }
 
 public void moveDown(){
  if (y > 19){
   y--; 
   direction = 3;
  }
 
 }
 }
public void addTile(int r, int c, color co){
  map[r][c] = new Tile(r,c,co); 
}


