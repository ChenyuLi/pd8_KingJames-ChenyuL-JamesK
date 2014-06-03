import java.util.*;
public class Bank extends Tiles{
    private ArrayList<Pokemon>pokemons;
    public Bank(){
        pokemons = null;
    }
    public void add(Pokemon pokemon){
        pokemons.add(pokemon);
    }
    public Pokemon look(int index){
        return pokemons.get(index);
    }
    public Pokemon retrieve(int index){
        return pokemons.remove(index);
    }
    public Pokemon exchange(int index, Pokemon pokemon){
        Pokemon poke = look(index);
        pokemons.set(index,pokemon);
        return poke;
    }
}
