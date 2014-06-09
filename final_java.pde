import java.util.*;
  
    final static int NORTH = 1;
    final static int EAST = 2;
    final static int SOUTH = 3;
    final static int WEST = 4;
    
    int state; //to change from intro, to main game, to battle scenes
    //1 main 2 battle 3 intro
    int istate; //same thing but for intro because intro has several parts
    int s;
    
    Pokemon User, Enemy;
    
    Tile[][]map;
    
    color brown = color(101,67,33);
    color blue = color(40,40,255);    
    color white = color(255,255,255);
    boolean moving = false;   
    double before;
  
    Player ash;
    
  color red =  color(245,20,20);
  
  //All the moves
  Moves Slas = new Moves("Slash");
  Moves Tackl = new Moves("Tackle");
  Moves Bit = new Moves("Bite");
  //All the Pokemons
  Moves[]charmanderMoves = new Moves[]{Slas};
  Pokemon Charmander = new Pokemon (15, 5, 5, 3, 2, charmanderMoves, "Charmander", "Charmander.jpg");
  Moves[]squirtleMoves = new Moves[]{Tackl};
  Pokemon Squirtle = new Pokemon (15, 5, 3, 5, 3, squirtleMoves, "Squirtle","Squirtle.jpg");
  Moves[]bulbasaurMoves = new Moves[]{Bit};
  Pokemon Bulbasaur = new Pokemon (15, 5, 4, 5, 2, bulbasaurMoves, "Bulbasaur","Bulbasaur.png");
  Pokemon[] Starters;
void setup(){
     size(400,400);
    frameRate(10);  
    
     map = new Tile[20][20];
  
  ash = new Player();
  state = 1;
  istate = 1;
 s = 0; 
 Starters = new Pokemon[]{Charmander, Squirtle, Bulbasaur};
    for (int i = 0; i < map.length; i++){
       for (int j = 0; j < map[0].length; j++){
          addTile(i,j,brown);
       } 
    }
    map[5][4] = new Tile(5,4);
}

public void addTile(int r, int c, color co){
  map[r][c] = new Tile(r,c,co); 
}
void battle(){
state = 3;
}  
void draw(){
   String lines[] = loadStrings("intro.txt");
   if (state == 1){
    
     if (istate == 1){
     PImage img;
     img = loadImage("Oak.png");
     image(img,80,0);   
     for (int i = 0; i < 4; i ++){
      text(lines[i],75,360 + i * 10);
     }
     if (keyPressed){
      if (key == ' '){
       istate = 2;
       before = millis();
      } 
     }
     }
     if (istate == 2){
       background(200,200);
     PImage img;
     img = loadImage("Oak.png");
     image(img,80,0); 
     for (int i = 4; i < 9; i ++){
      text(lines[i],75,320 + i * 10);
     }
     if (keyPressed && millis() - before > 100){
       if (key == ' '){
        istate = 3; 
       }
     }
     }
     if (istate == 3){
     background(200,200); 
     text(lines[9],75,370);
     Starters[s].display();
     if (keyPressed){
      if (key == '1'){
       if (s == 0){
        s = 2; 
       }
       else s -= 1;
      }
      if (key == '3'){
       if (s == 2){
         s = 0;
       }
       else s += 1;
      } 
     }
     }
   }
   if (state == 3){
     background (200);
   }
   else if (state == 2){
   ash.updateMap();
   for (int i = 0; i < map.length; i ++){
    for (int j = 0; j < map[0].length; j++){
        Tile t = map[i][j];
        t.display();
    } 
   }
  if (keyPressed){
   if (key == 'w'){
    ash.moveUp(); 
   }
   else if (key == 'd'){
   ash.moveRight(); 
   }
   else if (key == 's'){
    ash.moveDown(); 
   }
   else if (key == 'a'){
    ash.moveLeft(); 
   }
   else if (key == ' ' && ash.checkFront().isTrainer() == true){
     battle();
   }
  }   
}
}

class Tile{
   private int x, y;
   private color c; 
   private boolean occupied;
   private boolean trainer;
   
   public Tile(int r, int c){
    x = r;
    y = c;
    occupied = false;
    trainer = true;
   } 
   
    public Tile(int r, int c, color co){
       x = r;
       y = c;
       this.c = co;
        occupied = false;
       trainer = false; 
    }
    
    void yesOccupied(){
     occupied = true; 
    }
    void origColor(){
      occupied = false;
    }
    boolean isTrainer(){
     return trainer; 
    }
    void noOccupied(){
     occupied =false; 
    }
    
    public void display(){
     if (trainer == true){
       fill(blue); 
     }
     else if (occupied == true){
       fill(red);
     }
     else{
     fill(c);
     }
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
 
 //red until real image
 
 public Player(){
  x = 2;
  y = 16;
  direction = NORTH;
 }
 
 Tile checkFront(){
  Tile a = map[x][y-1];
   if (direction == NORTH){
   a = map[x][y-1];
  }
 return a; 
  
 }
 
void updateMap(){
 map[x][y].yesOccupied(); 
}
  void moveLeft(){
  if (x > 0){
   map[x][y].origColor();
   x--;
   direction = 4;
  } 
 }
 public void moveRight(){
  if (x< 19){
    map[x][y].origColor();
   x++;
   direction = 2;
}
 }
 
 public void moveDown(){
  if (y <19 ){
    map[x][y].origColor();
   y++;
   direction = 1;
  } 
 }
 
 public void moveUp(){
  if (y > 0){ if (ash.checkFront().isTrainer()!= true){
    map[x][y].origColor();
   y--; 
  }
  }
 direction = 3;
 
 }
 
}

class Pokemon{
  String Name, pict;
  int maxHp,curHp,level,exp,atk,spd,def;
  Moves[] moveSet; 
  boolean alive;
public Pokemon(int a,int b, int c, int d,int e, Moves[]f, String nam, String pic){
 maxHp = a;
curHp = maxHp;
level = b;
exp = 0;
atk = c;
spd = d;
def = e;
moveSet = f;
alive = true;
Name = nam;
pict = pic;
}
void display(){
 PImage img;
 img = loadImage(pict);
 image(img,80,50); 
}
void useMove(int i){
 moveSet[i].activate(); 
}
int getMaxHP(){
 return maxHp; 
}
void loseHP(int i){
  curHp -= i;
  if (curHp < 0){
   alive = false; 
   curHp = 0;
  }
}
int getCurHp(){
 return curHp; 
}
int getLevel(){
 return level; 
}
int getAtk(){
 return atk; 
}
int getDef(){
 return def; 
}
void addExp(int i){
  exp += i;
  if (exp > level * 4){
   exp = 0;
  level += 1; 
  }
}
}
class Moves{
  String moveName;
  String[] allMoves;

  public Moves(String i ){
  moveName = i;
  allMoves = new String[]{"Slash", "Tackle", "Bite", "Growl", "TailWhip", "Ember", "Bubble", "Razor Leaf"};
  }

  public void activate(){
   int track = 0;
   while (moveName != allMoves[track]){
    track++; 
   }
   if (track == 0){
     Enemy.loseHP(User.getAtk() - Enemy.getDef());
   }
   if (track == 1){
     Enemy.loseHP(User.getAtk() - Enemy.getDef());
   }
    if (track == 2){
     Enemy.loseHP(User.getAtk() - Enemy.getDef());
   }
  } 
}




