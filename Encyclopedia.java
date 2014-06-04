import java.util.*;
public class Encyclopedia{
    private ArrayList<Pokemon> a;
    private Moves[]moves;
    public Encyclopedia(){
	moves = new Moves[4];
	a = new ArrayList<Pokemon>();
	Pokemon b = new Pokemon("Charmander", "Fire", "insertcharmander","insertcharmeleon","insertcharizard","Charmeleon","Charizard",0,18,36,15,15,10,0,5,moves,5,5,5);
	a.add(b);
    }
    private Pokemon getPokemon(int i){
	return a.get(i);
    }
}
