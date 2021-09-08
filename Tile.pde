class Tile {
  
  public final static int SIZE = 65;
  private int number;
  
  private int x;
  private int y;
  
  public Tile(int number, int x, int y){
    this.number = number;
    this.x = x;
    this.y = y;
  }
  
  /**
   * Render the tile itself, and the relative number
   **/
  public void draw(){
    // tile
    fill(255, 255, 255);
    rect(x, y, SIZE, SIZE);
    
    // number text
    fill(0, 0, 0);
    text(number, x, y+SIZE);
  }
  
  /**
   * Gets the index relative to the board
   **/
  public int getIndex() { return number-1; }
  
  /**
   * Get the tile's x and y coordinates
   **/
  public PVector getCoordinates() { return new PVector(x + (SIZE/2), y + (SIZE/2)); }
}
