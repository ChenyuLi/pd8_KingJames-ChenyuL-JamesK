public class Pokeball implements Items{
    private int price;
    private int successRate;
    private Pokemon pokemon;
    public Pokeball(int price, int successRate){
        this.price = price;
        this.successRate = successRate;
        pokemon = null;
    }
    public int cost(){
        return price;
    }
    public Pokemon getPokemon(){
        return pokemon;
    }
    public void addPokemon(Pokemon pokemon){
        this.pokemon = pokemon;
    }
}
