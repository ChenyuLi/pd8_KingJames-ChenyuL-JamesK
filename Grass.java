public class Grass extends Tiles{
    private Pokemon[]pokemons;
    public Grass(Pokemon[]pokemons){
	this.pokemons = pokemons;
	player = null;
    }
    public boolean encounter(){
	return Math.random() < 0.1;
    }
    public Pokemon foe(){
	return pokemons[(int)(Math.random() * pokemons.length)];
    }
}
