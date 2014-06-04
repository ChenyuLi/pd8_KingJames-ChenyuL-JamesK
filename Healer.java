public class Healer extends Tiles{
    import java.util.*;
    private ArrayList<Pokemon>pokemons;
    public Healer(){
        pokemons = null;
    }
    public void add(Pokemon[] pokey){
        for (int i = 0; i < pokey.length; i++){
            pokemons.add(pokey[i]);
        }
    }
    public void heal(){
        for (int i = 0; i < pokemons.size(); i++){
            Pokemon temp = pokemons.get(i);
            temp.gainHP(temp.totalHP());
        }
    }
    public Pokemon[]  retrieve(){
        Pokemon[]temp = new Pokemon[pokemons.size];
        for (int i = 0; i < temp.length; i ++){
            temp[i] = pokemons.remove(i);
        }
    }
}
