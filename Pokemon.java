public class Pokemon{
    private String name,type,display,evolvestring2,evolvestring3,evolveName2,evolveName3;
    private int state,state2,state3,totalhp,currhp,totalexp,currexp,level,atk,spd,def;
    private Moves[]moves;

    public Pokemon(String a, String b,String bc, String c, String d, String e, String f, int g, int h, int i, int j, int k, int l, int m , int n, Moves[]o,int p, int q, int r){
	name = a;
	type = b;
	display = bc;
	evolvestring2 = c;
	evolvestring3 = d;
	evolveName2 = e;
	evolveName3 = f;
	state = g;
	state2 = h;
	state3 = i;
	totalhp = j;
	currhp = k;
	totalexp = l;
	currexp = m;
	level = n;
	moves = o;
	atk = p;
	spd = q;
	def = r;
	
    }
    public void loseHP(int n ){
	currhp = currhp - n;
	if (currhp < 0 ){
	    currhp = 0;
	}
    }
    
    public void gainHP(int n ){
	currhp = currhp + n;
	if (currhp > totalhp){
	    currhp = totalhp;
	}
    }

    public int getHP{
	return currhp;
    }
    
    public void loseExp(int n){
	currexp = currexp - n;
	if (currexp < 0){
	    currexp = 0;
	}
    }

    public void gainExp(int n){
	currexp = currexp + n;
	if (currexp > totalexp){
	    currexp = 0;
	    level = level +1;
	    if (state == 0){
		atk++;
		spd++;
		def++;
	    }
	    else if (state == 1){
		atk = atk+2;
		spd = spd+2;
		def = def+2;
	    }
	    else if (state == 2){
		atk = atk+4;
		spd = spd+4;
		def = def+4;
	    }
	    if (state == 0 && level >= state2){
		name = evolveName2;
		display = evolvestring2;
		state++;
		System.out.println("What's this! Your pokemon is evolving into a " + name);
	    }
	    else if (state == 1 && level >= state3){
		name = evolveName3;
		display = evolvestring3;
		state++;
		System.out.println("What's this! Your pokemon is evolving into a " + name);
	    }
	}
    }
    
    public void useMove(int n){
	if (moves[n] == null){
	    System.out.println("Try another move!");
	    useMove(n);
	}
	else moves[n].act();
    }
    
}