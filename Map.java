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
	return "a";
    }

}
    
