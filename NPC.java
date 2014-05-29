public class NPC implements Tiles{//this is an NPC
    private int money;
    private Pokemon[]pokemons;
    private String[]taunts;
    private int anger;//on scale of 5
    public NPC(Pokemon[]pokemons,String[]taunts){
	this.pokemons = pokemons;
	this.taunts = taunts;
	anger = 3;
	money = (int) (500 * Math.random());
    }
    public boolean encounter(){
	if (anger * Math.random() > 3){
	    anger = 1;
	    return true;//true means fight;
	}
	else if (anger < 5){
	    anger ++;
	    return false;
	}
	else{
	    return false;
	}
    }
    public int getMoney(){
	return money;
    }
    public String[] getTaunts(){
	return taunts;
    }
    public Pokemon[] getPokemons(){
	return pokemons;
    }
}
