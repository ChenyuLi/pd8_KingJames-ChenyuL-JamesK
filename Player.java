import java.util.*;
public class Player{
    private String name;
    private Pokemon[]pokemons;
    private ArrayList<Items> items;
    private int money;
    private int x,y;
    private Map map;//the map the player is currently on
    public Player(String name, Pokemon pokemon){
        this.name = name;
        pokemons = new Pokemon[6];
        pokemons[0] = pokemon;//Initial pokemon
        items = new ArrayList<Items>();
        money = 100;
        x = y = 0; //where to initialize the player?
    }
    public String getName(){
        return name;
    }
    public int getX(){
        return x;
    }
    public int getY(){
        return y;
    }
    public void changeMap(Map map){
        this.map = map;
    }
    public void moveLeft(){
        if (x > 0){
            x--;
        }
    }
    public void moveRight(){
        if (x < map.getWidth()-1){
            x--;
        }
    }
    public void moveUp(){
        if (y > 0){
            y--;
        }
    }
    public void moveDown(){
        if (y < map.getLength()-1){
            y++;
        }
    }
    public void changeMoney(int delta){
        money += delta;
    }
    public ArrayList<Items> getItems(){
        return items;
    }
    public Pokemon[] getPokemons(){
        return pokemons;
    }
    public String toString(){
	int i = 0;
	while (i < pokemons.length){
	    System.out.println(pokemons[i].getName());
	    i ++;
	}
	return "Yay";
    }
}
    
