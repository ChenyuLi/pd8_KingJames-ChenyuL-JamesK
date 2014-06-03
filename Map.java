public class Map{//healing center, town, and gym will implement this
    private Tiles[][]tiles;
    public Map(Tiles[][]a){
	tiles = a;
    }
    public int getWidth(){
	return tiles.length;
    }
    public int getLength(){
	return tiles[0].length;
    }
    public String toString(){
	String string = "";
	for (row = 0; row < a.length; row++){
	    string = string + tiles[row][0];
	        for (column = 1; column < tiles[row].length; column++) {
                    string = string + " " + tiles[row][column];
                }
            }
            string = string + "\n";
        }
	return string;	
    }
}
    
