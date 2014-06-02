import java.util.*;
public class Game{
    //intro
    public static void main(String[]args){
	System.out.println("Hi There! What's your name?");
	Scanner sc = new Scanner(System.in);
	String playerName = sc.nextLine();
	while (playerName.length() >15 || playerName.length() < 1){
	    System.out.println("Your name must be between 1 and 15 letters");
	    playerName = sc.nextLine();
	}
	System.out.println("Now choose a starter pokemon! You can choose a Charmander, Bulbasaur, or a Squirtle");
	String starterPokemon = sc.nextLine();
	while (!(starterPokemon.equals("Charmander")) || !(starterPokemon.equals("Bulbasaur"))|| !(starterPokemon.equals("Squirtle"))){
	    System.out.println("Make sure you type the pokemon's name correctly. Capitalize the first letter!");
	    starterPokemon = sc.nextLine();
	}
	Pokemon p = new Pokemon(starterPokemon);
	Player trainer = new Player(playerName, p);
	//testing purposes
	System.out.println(trainer.getName());
	System.out.println((trainer));
    }
}
