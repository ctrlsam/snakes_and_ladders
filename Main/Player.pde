class Player {

  private final static int SIZE = 20;
  private color pieceColor;
  private Tile position;
  private Animator animator;


  public Player(color pieceColor){
    this.pieceColor = pieceColor;
    animator = new Animator(this);
  }
  
  /**
   * Move a player to a new tile
   **/
  public void move(Tile newPosition){
    animator.addMove(position.getCoordinates(), newPosition.getCoordinates());
    position = newPosition;
  }
  
  /**
   * Draw player on grid
   **/
  public void draw(int x, int y){
    fill(pieceColor);
    ellipse(x, y, SIZE, SIZE);
  }
  
  /**
   * Returns the animator object used to draw the player
   **/
  public Animator getAnimator() { return animator; }
  
  /**
   * Returns the tile the player is currently in
   **/
  public Tile getPosition() { return position; }
  
  /**
   * Sets a new tile for the player
   **/
  public void setPosition(Tile position) { this.position = position; }
  
}
