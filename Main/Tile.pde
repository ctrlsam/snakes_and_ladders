class Tile {
  
  public final static int SIZE = 70;
  private int number;
  private color tileColor;
  
  private int x;
  private int y;
  
  public Tile(int number, int x, int y){
    this.number = number;
    this.x = x;
    this.y = y;
    tileColor = color(139, 190, 118);
  }
  
  /**
   * Render the tile itself, and the relative number
   **/
  public void draw(){
    // tile
    fill(tileColor); // Greeny
    rect(x, y, SIZE, SIZE);
    
    // number text
    fill(255, 255, 255); 
    text(number, x+10, y+20);
  }
  
  /**
   * Set tile color to an RGB value
   **/
  public void setColor(color tileColor){ this.tileColor = tileColor; }
  
  /**
   * Gets the index relative to the board
   **/
  public int getIndex() { return number-1; }
  
  /**
   * Get the tile's x and y coordinates
   **/
  public PVector getCoordinates() { return new PVector(x + (SIZE/2), y + (SIZE/2)); }
}
