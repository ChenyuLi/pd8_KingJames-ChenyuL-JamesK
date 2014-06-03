public class Encyclopedia{
    private ArrayList<Pokemon> a;
    public Encyclopedia(){
	a = new ArrayList<Pokemon>();
    }
    private Pokemon getPokemon(int i){
	return a.get(i);
    }
}