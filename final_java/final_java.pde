import java.util.*;
import ddf.minim.*;  
import java.util.concurrent.*;
    
    AudioPlayer player;
    Minim noise;
    
    final static int NORTH = 1;
    final static int EAST = 2;
    final static int SOUTH = 3;
    final static int WEST = 4;
    
    CLList<Pokemon> Starters;
    
    int state, istate, s, fstate;
    
    Pokemon User, Enemy;
    
    boolean trans,intro, canAttack, playmusic, introm;
    
    double before;
    
    long forsound;
    
    PImage img;
    
    Tile[][]map;
    
    color green = color(75,140,97);
    color blue = color(40,40,255);    
    color white = color(255,255,255);
    color black = color(0,0,0);
    color red =  color(245,20,20);

    Player ash;
    
    String fcomment,ecomment,wcomment;
    
  //All the moves
  Moves Slas = new Moves("Slash");
  Moves Tackl = new Moves("Tackle");
  Moves Bit = new Moves("Bite");
  Moves Grow = new Moves("Growl");
  Moves TailWhi = new Moves("TailWhip");
  Moves DefenseCur = new Moves("Defense Curl");
  Moves Embe = new Moves ("Ember");
  Moves Bubbl = new Moves ("Bubble");
  Moves RazorLea = new Moves ("Razor Leaf");
  Moves GigaImpac = new Moves ("Giga Impact");
  Moves OverHea = new Moves ("OverHeat");
  Moves HydroPum = new Moves ("Hydro Pump");
  Moves PsyBea = new Moves ("PsyBeam");
  Moves Thunde = new Moves ("Thunder");
  Moves PoisonStin = new Moves ("Poison Sting");
  Moves WingAttac = new Moves ("Wing Attack");
  
  //All the Pokemons and their movesets
  Moves[]charmanderMoves = new Moves[]{Slas,Grow,Embe,OverHea};
  Pokemon Charmander = new Pokemon (15, 5, 5, 3, 2, charmanderMoves, "Charmander", "Charmander.jpg");
  Moves[]squirtleMoves = new Moves[]{Tackl,DefenseCur,Bubbl,HydroPum};
  Pokemon Squirtle = new Pokemon (15, 5, 3, 5, 3, squirtleMoves, "Squirtle","Squirtle.jpg");
  Moves[]bulbasaurMoves = new Moves[]{Bit, TailWhi, RazorLea, GigaImpac};
  Pokemon Bulbasaur = new Pokemon (15, 5, 4, 5, 2, bulbasaurMoves, "Bulbasaur","Bulbasaur.png");
  Moves[]espeonMoves = new Moves[]{Tackl,TailWhi,Grow,PsyBea};
  Pokemon Espeon = new Pokemon (12, 4, 4, 2, 2, espeonMoves, "Espeon", "Espeon.png");
  Moves[]jolteonMoves = new Moves[]{Tackl,TailWhi,Grow,Thunde};
  Pokemon Jolteon = new Pokemon (12, 4, 4, 2, 2, jolteonMoves, "Jolteon", "Jolteon.jpg");
  Moves[]ekansMoves = new Moves[]{Bit, Tackl, DefenseCur, PoisonStin};
  Pokemon Ekans = new Pokemon (7, 3, 3, 3, 3, ekansMoves, "Ekans", "Ekans.gif");
  Moves[]pidgeyMoves = new Moves[]{Slas, Bit, DefenseCur, WingAttac};
  Pokemon Pidgey = new Pokemon(6, 3, 4, 4, 1, pidgeyMoves, "Pidgey", "Pidgey.png");
  Moves[]krabbyMoves = new Moves[]{ Bit, Bubbl, HydroPum, DefenseCur};
  Pokemon Krabby = new Pokemon(10, 4, 2, 2, 5, krabbyMoves, "Krabby","Krabby.png");
  Moves[]growlitheMoves = new Moves[]{Tackl, Bit, Embe, OverHea};
  Pokemon Growlithe = new Pokemon (15, 6, 5, 5, 2, growlitheMoves, "Growlithe", "Growlithe.jpg");
  Moves[]turtwigMoves = new Moves[]{ Tackl, Bit, RazorLea, GigaImpac};
  Pokemon Turtwig = new Pokemon (18, 7, 6, 3, 6, turtwigMoves, "Turtwig", "Turtwig.jpg");
  Moves[]zigzagoonMoves = new Moves[]{Tackl, DefenseCur, GigaImpac, Slas};
  Pokemon Zigzagoon = new Pokemon (17, 7, 5, 5, 5, zigzagoonMoves,"Zigzagoon","Zigzagoon.png");
  Pokemon[] pokemonList1 = new Pokemon[]{Espeon, Jolteon, Ekans, Pidgey, Krabby};
  Pokemon[] pokemonList2 = new Pokemon[]{Growlithe, Turtwig, Zigzagoon};
  
  ArrayList<Pokemon> manA, manB, boss;
    
  ArrayList<Pokemon> dreamteam;
  
void setup(){
  size(400,400);
  frameRate(20);
  frame.setResizable(true);

  forsound = millis();
    
  fcomment = ecomment = wcomment= "";
    
  manA = new ArrayList<Pokemon>();
  manA.add(new Pokemon(12, 4, 3, 4, 1, pidgeyMoves, "Pidgey","Pidgey.png"));
   
  manB = new ArrayList<Pokemon>();
  manB.add(new Pokemon(18,7,6,3,6,turtwigMoves,"Turtwig","Turtwig.jpg"));
   
  boss = new ArrayList<Pokemon>();
  boss.add(new Pokemon(30, 10, 8, 4, 4, espeonMoves,"Espeon","Espeon.png"));
   
  trans = false;
  
  map = new Tile[20][20];
  
  dreamteam = new ArrayList<Pokemon>();
  
  ash = new Player();
  
  state = istate = 1;
  fstate = 0;
  s = 0; 
  
  canAttack = playmusic = intro = introm = true;

 Starters = new CLList<Pokemon>();
 Starters.add(Charmander);
 Starters.add(Squirtle);
 Starters.add(Bulbasaur);
   
 for (int i = 0; i < map.length; i++){
   for (int j = 0; j < map[0].length; j++){
          addTile(i,j,green);
   } 
  }
  
  map[5][4] = new Tile(5,4,manA);
  map[17][2] = new Tile(17,2, manB);
  map[17][16] = new Tile(17,16, boss, 1);
  map[2][16].yesOccupied();

 for (int i = 1; i < 4; i ++){
  for (int j = 1; j < 10; j ++){
   map[i][j].beGrass();
  } 
 }
 
 for (int i = 7; i < 13; i++){
  for (int j = 15; j < 18; j++){
   map[i][j].beGrass();
  } 
 }
 
 for (int i = 9; i < 16; i++){
  for (int j = 3; j < 8 ; j++){
  map[i][j].beGrass2();
  } 
 }
 
 for (int i = 16; i < 20; i++){
  for (int j = 9; j < 14; j++){
   map[i][j].beWater();
  } 
 }

 map[15][10].beWater();
 map[15][11].beWater();
 map[15][12].beWater();
 map[14][11].beWater();
 map[17][8].beWater();
 map[18][8].beWater();
 map[19][8].beWater();
 map[18][7].beWater();
 map[19][7].beWater();
 map[19][6].beWater();
 map[16][12].beWater();
 map[17][12].beWater();
 map[18][12].beWater();
 map[17][14].beWater();
 map[18][14].beWater();
 map[19][14].beWater();
 map[18][15].beWater();
 map[19][15].beWater();
 map[19][16].beWater();
 
 map[10][10].beHealer();


}

public void addTile(int r, int c, color co){
  map[r][c] = new Tile(r,c,co); 
}
void battle(){
state = 3;
}
void setEnemy(Pokemon p){
 Enemy = p; 
}
void draw(){
  if (introm == true){
  if ( playmusic == true){
  noise = new Minim(this);
  player = noise.loadFile("pokemontheme.mp3");
  player.play();
  forsound = millis();
  playmusic = false;
  }
  if (millis() - forsound > 198000){
   playmusic = true; 
  }
  }
  if(introm == false){
  if ( playmusic == true){
  noise = new Minim(this);
  player = noise.loadFile("pokemonbackground.mp3");
  player.play();
  forsound = millis();
  playmusic = false;
  }
  if (millis() - forsound > 90999.96){
   playmusic = true; 
  }
  }
  
  if (intro == true){
    frame.setSize(1000,563);
    img = loadImage("introScreen.jpg");
    image(img, 0, 0);
    fill(black);
    text("Press 1 to Continue", 200,400);
    if (keyPressed){
     if (key == '1'){
      intro = false;
      frame.setSize(400,450);
     } 
    }
  }
  else{
   background(white);
   String lines[] = loadStrings("intro.txt");
   if (state == 1){
    
     if (istate == 1){
     img = loadImage("Oak.png");
     image(img,80,0);   
     for (int i = 0; i < 4; i ++){
      text(lines[i],50,360 + i * 12);
     }
     if (keyPressed){
      if (key == ' '){
       istate = 2;
       before = millis();
      } 
     }
     }
     if (istate == 2){
       background(white);
     img = loadImage("Oak.png");
     image(img,80,0); 
     for (int i = 4; i < 9; i ++){
      text(lines[i],50,305 + i * 12);
     }
     if (keyPressed && millis() - before > 300){
       if (key == ' '){
         before = millis();
         istate = 3; 
       }
     }
     }
     if (istate == 3){
     background(white); 
     text(lines[9],75,370);
     Starters.get(s).display();
     if (keyPressed && millis() - before > 300){
      if (key == '1'){
       if (s == 0){
        s = 2; 
       }
       else s -= 1;
     delay(100); 
     }
      if (key == '3'){
       if (s == 2){
         s = 0;
       }
       else s += 1;
       delay(100);
      }
     if (key == '2'){
      dreamteam.add(Starters.get(s));
      User = dreamteam.get(0);
      before = millis();
       istate = 4;
     } 
     }
     }
     if (istate == 4){
      frame.setSize(500,600);
       background(white);
     img = loadImage("Oak.png");
     image(img,150,0); 
     for (int i = 12; i < 29; i ++){
      text(lines[i],10,220 + i * 12);
     }
      if (keyPressed && millis() - before > 300){
       if (key == ' '){ 
       istate = 5; 
       frame.setSize(410,430);
       before = millis();
      }
     }
     }
     if (istate == 5){
      background(white);
     img = loadImage("begin.jpg");
    image (img, 0, 0);
   text("Your Journey to Become the Best has Started!", 75, 300);
   text("Good Luck and Have Fun!!!", 100,320);
   if (keyPressed && millis() - before > 300){
    if (key == ' '){
     player.close();
     introm = false;
     playmusic = true;
     state = 2; 
    }
   } 
     }
   }
   if (state == 3){
     fill(black);
     frame.setSize(800,500);
     background (white);
     User = dreamteam.get(0);
     User.displayL();
     Enemy.displayR();
     text(lines[10],400,250);
     text(User.getName(), 80 , 320);
     text(Enemy.getName(),620,320);
     String tempo = "Lv: " + User.getLevel();
     text(tempo,80,340);
     String tempo2 = "Lv: " + Enemy.getLevel();
     text(tempo2,620,340);
     fill(red);
     String tempo3 = "HP: " + User.getCurHp()+ " / "+ User.getMaxHP();
     text(tempo3,80, 360);
     String tempo4 = "HP: " + Enemy.getCurHp() + " / " + Enemy.getMaxHP();
     text(tempo4,620,360);
     fill(blue);
     String tempo5 = "EXP: " + User.getExp() + " / " + User.getLevel()*2;
     text(tempo5,80, 380);
     text(fcomment,80,400); 
     text(ecomment,80,420); 

     if (fstate == 0){
     fill(black);
     text(lines[11],50,450);
     if (keyPressed){
      if (key == 'q'){
        fstate = 1; 
      }
     if (key == 'e'){
      state = 2;
     } 
     }
     }
     if (fstate == 1){
       
       User.getMoves();
       if (keyPressed){
         if (canAttack == true ){
       if (key == '1' || key == '2' || key == '3' || key == '4'){
         int a = Character.getNumericValue(key);
         fcomment = User.useMove(a-1, Enemy);         
         canAttack = false;
         ecomment = Enemy.useRMove(User);
         if (User.getCurHp()== 0){      
           before = millis();
           state = 6;
         }
         else if (Enemy.getCurHp() == 0){
            fstate = 2;
            wcomment = User.addExp(Enemy.getLevel());
           }
       }
       }
       delay(100);
       canAttack = true;
       }
     }
     else if (fstate == 2){
       
        text(wcomment,320,440); 
        String tem = Enemy.getName() + " Has Fainted! (Click Space to Continue)";
        text(tem, 270,200);
      if (keyPressed){
       if (key == ' '){
         frame.setSize(400,400);
         fstate = 0;
         state = 41; 
         wcomment = "";
       }
      } 
     }
   }
   if (state == 41){
      ash.checkFront().yesDefeated();
     background(white);
     if (ash.checkFront().isBoss()){
     img = loadImage("bossTrainer.png");
     }
     else img = loadImage("enemyTrainer.png");
     image(img,140,0);
     fill(black);
     text("You Really Have Strong Pokemon!", 120, 350); 
   if (keyPressed){
   if (key == ' ' && millis() - before > 300){
     trans = true;
    state = 2; 
   }
   }  
   }
   if (state == 42){
     background(white);
    if (ash.checkFront().isBoss()){
    img = loadImage("bossTrainer.png");
    }
    else img = loadImage("enemyTrainer.png");
    image(img, 140, 0);
    fill(black);
   text ("I Challenge You To A Battle!!!",120,350);
   ash.checkFront().setEnemy();
   if (keyPressed){
    if (key == ' ' && millis() - before > 300){
     delay(400);
     state = 3; 
    }
   } 
   }
 
    
   else if (state == 2){
   frame.setSize(410,430);
   ecomment = fcomment = "";
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
     if (map[ash.getX()][ash.getY()].isGrass() == true){
     if ((int)random(15) == 0){
     Pokemon a = (Pokemon)(pokemonList1[((int)random(5))].clone());
     Enemy = a;
     state = 3;
     fstate = 0;
     }
   }
   else if(map[ash.getX()][ash.getY()].isGrass2() == true){
      if ((int)random(15)==0){
     Pokemon a = (Pokemon)(pokemonList2[((int)random(3))].clone());
     Enemy = a;
     state = 3;
     fstate = 0;
      } 
     }
   }
   else if (key == 'd'){
   ash.moveRight(); 
  if (map[ash.getX()][ash.getY()].isGrass() == true){
     if ((int)random(15) == 0){
     Pokemon a = (Pokemon)(pokemonList1[((int)random(5))].clone());
     Enemy = a;
     state = 3;
     fstate = 0;
     }
     else if(map[ash.getX()][ash.getY()].isGrass2() == true){
      if ((int)random(15)==0){
     Pokemon a = (Pokemon)(pokemonList2[((int)random(3))].clone());
     Enemy = a;
     state = 3;
     fstate = 0;
      } 
     }
   }  
 
 }
   else if (key == 's'){
    ash.moveDown(); 
  if (map[ash.getX()][ash.getY()].isGrass() == true){
     if ((int)random(15) == 0){
     Pokemon a = (Pokemon)(pokemonList1[((int)random(5))].clone());
     Enemy = a;
     state = 3;
     fstate = 0;
     }
     else if(map[ash.getX()][ash.getY()].isGrass2() == true){
      if ((int)random(15)==0){
     Pokemon a = (Pokemon)(pokemonList2[((int)random(3))].clone());
     Enemy = a;
     state = 3;
     fstate = 0;
      } 
     }
   }  
 }
   else if (key == 'a'){
    ash.moveLeft(); 
  if (map[ash.getX()][ash.getY()].isGrass() == true){
     if ((int)random(15) == 0){
     Pokemon a = (Pokemon)(pokemonList1[((int)random(5))].clone());
     Enemy = a;
     state = 3;
     fstate = 0;
     }
   }
 else if(map[ash.getX()][ash.getY()].isGrass2() == true){
      if ((int)random(15)==0){
     Pokemon a = (Pokemon)(pokemonList2[((int)random(3))].clone());
     Enemy = a;
     state = 3;
     fstate = 0;
      } 
     }  
 }
   else if (key == ' '){
     if (ash.checkFront().isHealer()){
       state = 5;
     }
     else if (ash.checkFront().isBoss() == true || ash.checkFront().isTrainer() == true){
     if (ash.checkFront().getDefeated() == false){
       ash.checkFront().setEnemy();
       before = millis();
       state = 42;
     }
     else if (ash.checkFront().getDefeated() == true && trans == false){ 
       before = millis();
       state = 41;
       }
    trans = !trans;
   }
  }   
}
  }
  else if (state == 5){
    User.recover();
    background(black);
    if (User == Charmander){
     img = loadImage("charheal.jpg");
    }
    else if (User == Squirtle){
     img = loadImage("squirtleheal.jpg"); 
    }
    else {
     img = loadImage("bulbasaurheal.jpg"); 
    }
    image(img, 0, 0);
    fill(white);
    text("Your Pokemon Feels Energy Coursing Through Its Veins!",50,300);
    text("Press 1 to Continue with your Pokemon Stronger Than Ever!",40,320);
    if (keyPressed){
     if (key == '1'){
      state = 2;
     } 
    }
  }
  else if (state == 6){
    if (millis() - before < 5000){
    frame.setSize(640,480);
    img = loadImage("critical.jpg");
    image(img,0,0);
    fill(white);
    text("OH NO YOUR POKEMON HAS TAKEN SEVERE DAMAGE!",200,400);
    }
    else{
    frame.setSize(720,800);
    img = loadImage("gameover.jpg");
    image(img,0,0);
    fill(black);
    text("Game Over", 50,600);
    } 
}
  else if (state ==7){
   frame.setSize(500,337);
   img = loadImage ("winner.jpg");
   image(img,0,0);
   fill(white);
   text("Congratulations!",0,180);
   text("You Have Won the Game!",0, 200);
  }
}
if (map[17][16].getDefeated() == true){
 state = 7;
}
}

class Tile{
   private int x, y;
   private color c; 
   private boolean occupied, grass, grass2, land, water, trainer, defeated, boss, healer;
   private ArrayList<Pokemon> reamTeam;
   
   public Tile(int r, int c, ArrayList<Pokemon> a){
    x = r;
    y = c;
    occupied = false;
    trainer = true;
    reamTeam = a;
    defeated = false;
    grass = false;
    grass2 = false;
    land = false;
    water = false;
    boss = false;
    healer = false;
   } 
    public Tile(int r, int c, ArrayList<Pokemon> a, int d){
    x = r;
    y = c;
    occupied = false;
    trainer = false;
    reamTeam = a;
    defeated = false;
    grass = false;
    grass2 = false;
    land = false;
    water = false;
    boss = true;
    healer = false;
   } 
   
    public Tile(int r, int c, color co){
       x = r;
       y = c;
       this.c = co;
        occupied = false;
       trainer = false; 
       defeated = false;
       grass = false;
       grass2 = false;
       land = false;
       water = false;
       healer = false;
    }
    void beHealer(){
     healer = true; 
    }
    
    void setEnemy(){
     Enemy = reamTeam.get(0); 
    }
    void beGrass(){
     grass = true;
    }
    
    void beGrass2(){
     grass2 = true; 
    }
    
    void beLand(){
     land = true; 
    }
    void beWater(){
     water = true; 
    }
    boolean isHealer(){
     return healer; 
    }
    boolean isWater(){
     return water; 
    }
    boolean isBoss(){
     return boss; 
    }
    boolean isGrass(){
     return grass;
    }
    boolean isGrass2(){
     return grass2; 
    }
    boolean getDefeated(){
      return defeated;
    }
    
    void yesDefeated(){
     defeated = true; 
    }
    
    
    boolean getOccupied(){
     return occupied; 
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
    
    void display(){
     if (boss == true){
       img = loadImage("granny.jpg");
       image(img, x*20, y*20);
     }
     else if (healer == true){
     img = loadImage("healer.png");
     image(img, x*20, y*20);
     }
     else if (water == true){
     img = loadImage("water.jpg");
    image (img, x*20, y*20); 
     }
     else if (trainer == true){
        img = loadImage("manA.jpg");
    image(img, x * 20,y * 20); 
     }
     else if (grass == true && occupied == true|| grass2 == true && occupied == true){
         if (ash.getDirection() == 1){
     img = loadImage("tgrassS.jpg");
     image(img,x*20 ,y*20);
       }
          if (ash.getDirection() == 2){
     img = loadImage("tgrassE.jpg");
     image(img,x*20,y*20);
       }
          if (ash.getDirection() == 3){
     img = loadImage("tgrassN.jpg");
     image(img,x*20,y*20);
       }
          if (ash.getDirection() == 4){
     img = loadImage("tgrassW.jpg");
     image(img,x*20,y*20);
       }
     }
     else if (grass == true || grass2 == true){
     img = loadImage("grass.png");
     image (img, x*20, y*20);
     }
      else if (occupied == true){
       if (ash.getDirection() == 1){
     img = loadImage("redD.jpg");
     image(img,x*20,y*20);
       }
          if (ash.getDirection() == 2){
     img = loadImage("redR.jpg");
     image(img,x*20,y*20);
       }
          if (ash.getDirection() == 3){
     img = loadImage("redT.jpg");
     image(img,x*20,y*20);
       }
          if (ash.getDirection() == 4){
     img = loadImage("redS.jpg");
     image(img,x*20,y*20);
       }
     }
     else{
      fill(c);
      rect(x * 20,y * 20,20,20); 
    }  
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
 int getX(){
  return x;
 }
 int getY(){
  return y; 
 }
 int getDirection(){
  return direction; 
 }
 Tile checkFront(){
   Tile a;
   if (direction == NORTH){
   return checkFrontN();
  }
  else if (direction == SOUTH){
   return checkFrontS();
  }
  else if (direction == WEST){
   return checkFrontW();
  }
  else if (direction == EAST){
   return checkFrontE();
  }
  else {
   a = map[x][y-1]; 
  }
 return a; 
 }
 Tile checkFrontN(){
   Tile a = map[x][y+1];
   return a;
 }
 Tile checkFrontS(){
  Tile a = map[x][y-1];
 return a; 
 }
 Tile checkFrontE(){
  Tile a = map[x+1][y];
 return a; 
 }
 Tile checkFrontW(){
  Tile a = map[x-1][y];
 return a; 
 }
void updateMap(){
 map[x][y].yesOccupied(); 
}
  void moveLeft(){
       direction = 4;
  if (x > 0){ if(ash.checkFront().isTrainer()!= true && ash.checkFront().isBoss() != true && ash.checkFront().isWater() != true && ash.checkFront().isHealer()!= true){
   map[x][y].origColor();
   x--;
  }
  }
  }
 
 void moveRight(){
      direction = 2;
  if (x< 19){if (ash.checkFront().isTrainer()!= true && ash.checkFront().isBoss() != true && ash.checkFront().isWater() != true && ash.checkFront().isHealer()!= true){
    map[x][y].origColor();
   x++;
  }
  }
 }
 
 void moveDown(){
      direction = 1;
  if (y <19 ){if (ash.checkFront().isTrainer()!= true && ash.checkFront().isBoss() != true && ash.checkFront().isWater() != true && ash.checkFront().isHealer() != true){
    map[x][y].origColor();
   y++;
  }
  }
  }
 
 void moveUp(){
    direction = 3;
  if (y > 0){ if (ash.checkFront().isTrainer()!= true && ash.checkFront().isBoss() != true && ash.checkFront().isWater() != true && ash.checkFront().isHealer()!= true){
    map[x][y].origColor();
   y--;
  }
  }
 }
}

public class Pokemon implements Cloneable{
  String Name, pict;
  int maxHp,curHp,level,exp,atk,spd,def;
  Moves[] moveSet; 
  public Pokemon(int a,int b, int c, int d,int e, Moves[]f, String nam, String pic){
   maxHp = a;
   curHp = maxHp;
   level = b;
   exp = 0;
   atk = c;
   spd = d;
   def = e;
   moveSet = f;
   Name = nam;
   pict = pic;
}

  Object clone(){
   try {
    return super.clone();
   } catch(Exception e){
    return null; 
   }
  }

  int getExp(){
   return exp; 
  }

  void recover(){
   curHp = maxHp; 
  }

  String getName(){
   return Name; 
  }

  String getPic(){
   return pict;  
  }

  void display(){
   img = loadImage(pict);
   image(img,80,50);
  }

  void getMoves(){
   String ret = "";
   fill(black);
   for (int i = 0; i < moveSet.length; i++){
       ret = ret + "<" + (i + 1) + ">" + moveSet[i];
   } 
   text(ret,50,450);
  }

  void displayL(){
   img = loadImage(pict);
   image(img, 0, 50);
  }

  void displayR(){
   img = loadImage(pict);
   image(img, 550, 50);
  }

  String useMove(int i, Pokemon p){
    return moveSet[i].activate(this, p); 
  }

  String useRMove(Pokemon p){
    int i = int(random(moveSet.length));
    return moveSet[i].activate(this, p);
  }

  int getMaxHP(){
   return maxHp; 
  }

  void loseHP(int i){
    curHp -= i;
   if (curHp < 0){
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

 void loseAtk(int i){
  atk -= i;
 if (atk <= 1){
  atk = 1;
 } 
}

 void gainAtk(int i){
  atk += i;
 }

 int getDef(){
  return def; 
 }

void loseDef(int i){
 def -= i;
 if (def <= 1){
  def = 1;
 }
}

void gainDef(int i ){
 def +=i; 
}

String addExp(int i){
 String ret = "";
  exp += i;
  ret = "Wow " + this.getName() + " Has gained " + i + " Exp!";
  if (exp >= level * 2){
   exp = 0;
  level += 1;
  atk += 1;
  spd += 1;
  def += 1;
  maxHp +=3;
   ret = "Wow " + this.getName() + " Has Leveled!";
  }
  return ret;
}
}
class Moves{
  String moveName;
  String[] allMoves;

  public Moves(String i ){
  moveName = i;
  allMoves = new String[]{"Slash", "Tackle", "Bite", "Growl", "TailWhip", "Defense Curl", "Ember", "Bubble", "Razor Leaf", "Giga Impact", "OverHeat", "Hydro Pump", "PsyBeam", "Thunder", "Poison Sting","Wing Attack"};
  }

  String activate(Pokemon U, Pokemon E){
   String end, init;
   String ret = "";
   int track = 0;
   while (!(moveName.equals(allMoves[track]))){
    track++; 
   }
   init = U.getName() + " Has Used "+ moveName + ". ";
   if (track == 0){
     int temp = U.getAtk() - E.getDef();
     if (temp <= 0){
      temp = 1; 
     }
     E.loseHP(temp);
   ret = E.getName()+ " Has Lost " + temp + " HP!"; 
  }
   if (track == 1){
    int temp = U.getAtk() - E.getDef();
    if (temp <= 0){
      temp = 1; 
     }
     E.loseHP(temp);
   ret = E.getName()+ " Has Lost " + temp + " HP!";    
 }
    if (track == 2){
    int temp = U.getAtk() - E.getDef();
    if (temp <= 0){
      temp = 1; 
     }
     E.loseHP(temp);
   ret = E.getName()+ " Has Lost " + temp + " HP!";    
 }
 if (track == 3){
  int temp = int(U.getAtk() * .5);
  if (temp <= 0){
      temp = 1; 
     }
  E.loseDef(temp);
 ret = E.getName() + " Has Lost " + temp + " Def!"; 
 }
 if (track == 4){
 int temp = int(U.getAtk() * .5);
 if (temp <= 0){
      temp = 1; 
     }
  E.loseDef(temp);
 ret = E.getName() + " Has Lost " + temp + " Def!";  
 }
if (track == 5){
 int temp = int(U.getDef() * .5);
 if (temp <= 0){
  temp = 1; 
 }
  E.gainDef(temp);
 ret = U.getName() + " Has Gain " + temp + " Def!";  
 }
 if (track == 6){
 int temp = int(U.getAtk() *1.2);
  E.loseHP(temp);
 ret = E.getName() + " Has Lost " + temp + " HP!";  
 }if (track == 7){
 int temp = int(U.getAtk() * 1.2);
  E.loseHP(temp);
 ret = E.getName() + " Has Lost " + temp + " HP!";  
 }if (track == 8){
 int temp = int(U.getAtk() * 1.2);
  E.loseHP(temp);
 ret = E.getName() + " Has Lost " + temp + " HP!";  
 }if (track == 9){
 int temp = int(U.getAtk() * 2);
 int temp2 = int(U.getAtk() * .5);
  E.loseHP(temp);
   if (temp2 <= 0){
  temp2 = 1; 
 }
  U.loseHP(temp2);
 ret = E.getName() + " Has Lost " + temp + " HP! " + U.getName() + " Has Been Hit with Recoil!";  
 }if (track == 10){
 int temp = int(U.getAtk() * 2);
 int temp2 = (int (U.getAtk() * .5));
  if (temp2 <= 0){
  temp2 = 1; 
 }
  U.loseAtk(temp2);
  E.loseHP(temp);
 ret = E.getName() + " Has Lost " + temp + " HP! " + U.getName() + " is Tired! Atk has Decreased!";  
 }
 if (track == 11){
 int temp = int(U.getAtk() * 2);
 int temp2 = (int (U.getDef() * .5));
  if (temp2 <= 0){
  temp2 = 1; 
 }
 U.loseDef(temp2);
  E.loseHP(temp);
 ret = E.getName() + " Has Lost " + temp + " HP! " + U.getName() + " is Tired! Def has Decreased!";  
 }
  if (track == 12){
 int temp = int(U.getAtk() * 1.2);
  E.loseHP(temp);
 ret = E.getName() + " Has Lost " + temp + " HP!";  
 }
  if (track == 13){
 int temp = int(U.getAtk() *1.2);
  E.loseHP(temp);
 ret = E.getName() + " Has Lost " + temp + " HP!";  
 }
  if (track == 14){
 int temp = int(U.getAtk() *1.2);
  E.loseHP(temp);
 ret = E.getName() + " Has Lost " + temp + " HP!";  
 }
  if (track == 15){
 int temp = int(U.getAtk() *1.2);
  E.loseHP(temp);
 ret = E.getName() + " Has Lost " + temp + " HP!";  
 }
 end = init + ret;
 return end;
  }
  String toString(){
    return moveName; 
  } 
}
/*****************************************************
 * class CLList 
 * implements a circularly-linked list of doubly-linked nodes
 ******************************************************/
class CLList<T> {

    // only 1 head/tail/front/end pointer is necessary,
    // since the list is circularly-linked
    private DLLNode<T> _head;
    private int _size = 0;

    public CLList() {
  _head = null;
  _size = 0;
    }

 public int size() { return _size; }

 public boolean add( T x ) {

  if ( size() == 0 ) {
      _head = new DLLNode<T>( x, null, null );
      _head.setNext( _head );
      _head.setPrev( _head );
  }
  else {
      DLLNode<T> oldLast = _head.getPrev();

      // insert new node between head and oldLast
      _head.setPrev( new DLLNode<T>( x, oldLast, _head) );
      oldLast.setNext( _head.getPrev() );
        }
  _size++;

  return true;
    }


 public T get( int index ) {

  DLLNode<T> tmp = _head;

  for( int i = 0; i < index % size(); i++ )
      tmp = tmp.getNext();

  return tmp.getValue();
    }


 public T set( int index, T newVal ) {

  T foo;
  DLLNode<T> tmp = _head;

  for( int i = 0; i < index % size(); i++ )
      tmp = tmp.getNext();

  foo = tmp.setValue( newVal );
  
  return foo;
    }


 public String toString() {
  String foo = "HEAD-> ";
  DLLNode<T> tmp = _head;
  for( int i = 0; i < _size; i++ ) {
      foo += tmp.getValue() + " <-> ";
      tmp = tmp.getNext();
  }
  if ( foo.length() > 7 )
      foo = foo.substring( 0, foo.length() - 5 );
  foo += " <--...back to HEAD";
  return foo;
    }
}//end class CLList
/*****************************************************
 * class DLLNode
 * Implements a doubly-linked node, for use in linear container classes.
 *****************************************************/

public class DLLNode<T> {

    private T _cargo;    //cargo may only be of type T
    private DLLNode<T> _nextNode, _prevNode; //pointers to next, prev DLLNodes


    // constructor -- initializes instance vars
    public DLLNode( T value, DLLNode<T> prev, DLLNode<T> next ) {
  _cargo = value;
  _nextNode = next;
  _prevNode = prev;
    }


    //--------------v  ACCESSORS  v--------------
    public T getValue() { return _cargo; }

    public DLLNode<T> getNext() { return _nextNode; }

    public DLLNode<T> getPrev() { return _prevNode; }
    //--------------^  ACCESSORS  ^--------------


    //--------------v  MUTATORS  v--------------
    public T setValue( T newVal ) {
  T foo = getValue();
  _cargo = newVal;
  return foo;
    }

    public DLLNode<T> setNext( DLLNode<T> newNext ) {
  DLLNode<T> foo = getNext();
  _nextNode = newNext;
  return foo;
    }

    public DLLNode<T> setPrev( DLLNode<T> newPrev ) {
  DLLNode<T> foo = getPrev();
  _prevNode = newPrev;
  return foo;
    }
    //--------------^  MUTATORS  ^--------------



    // override inherited toString
    public String toString() { return _cargo.toString(); }


}//end class DLLNode




