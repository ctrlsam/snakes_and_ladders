class Board {
  
  private Tile[] tiles;
  private ArrayList<Player> players;
  private Snake[] snakes;
  private Ladder[] ladders;
  private Player winner;
  

  public Board(ArrayList<Player> players, Snake[] snakes, Ladder[] ladders){
    tiles = new Tile[100];
    this.players = players;
    this.snakes = snakes;
    this.ladders = ladders;
    
    generate();
    
    // Color tiles with snakes
    for (Snake snake : snakes){
      tiles[snake.getStart()].setColor(color(45, 154, 238));
      tiles[snake.getEnd()].setColor(color(231, 52, 72));
    }
    
    // Color tiles with ladders
    for (Ladder ladder : ladders){
      tiles[ladder.getStart()].setColor(color(246, 169, 0));
      tiles[ladder.getEnd()].setColor(color(237, 190, 0));
    }
    
    
  }
  
  /**
   * Generate Board tiles
   **/
  private void generate(){
    int x = 0;
    int y = 0;
    boolean left = false;
    
    for (int i = 0; i < tiles.length; i++){
      int squareNum = tiles.length-1-i;
      tiles[squareNum] = new Tile(squareNum+1, x, y);
      
      if ((i+1) % 10 == 0){ // new row
        y += Tile.SIZE;
        left = !left;
      }
      
      else { // same row
        if (left) x -= Tile.SIZE;
        else x += Tile.SIZE;
      }
    }
  }
  
  /**
   * Handle player landing on a snake or a ladder
   **/
  private void handlePaths(Player player){
    int pos = player.getPosition().getIndex();
    
    for (Snake snake : snakes){
      if (snake.getStart() == pos){ // move down snake
        player.move(tiles[snake.getEnd()]);
      }
    }
    
    for (Ladder ladder : ladders){
      if (ladder.getStart() == pos){ // move up ladder
        player.move(tiles[ladder.getEnd()]);
      }
    }
    
  }
  
  /**
   * Adds player to board if not already on it,
   * Moves player on board by the amount on roll
   * Also, handles an "Over-Roll"
   **/
  public void move(Player player, int roll){
    
    if (player.getPosition() == null){
      println("Player entering board");
      player.setPosition(tiles[0]);
    }
    
    println("Rolled a " + roll);
    
    int current = player.getPosition().getIndex();
    int target = current + roll;
    boolean hitEnd = false;
    
    while (current != target){
      
      if (hitEnd) target = 99 - (roll - (99 - current));
      if (current < target) current++;
      else if (current > target) current--;
      
      if (current == 99) hitEnd = true;
      Tile tile = tiles[current];
      player.move(tile);
    }
    
    player.move(tiles[target]);
    handlePaths(player);
    if (target == 99) winner = player;
  }
  
  /**
   * Renders the tiles, snakes, ladders and players
   **/
  public void draw(){
    
    for (Tile tile : tiles){
      tile.draw();
    }
    
    for (Snake snake : snakes){
      PVector start = tiles[snake.getStart()].getCoordinates();
      PVector end = tiles[snake.getEnd()].getCoordinates();
      snake.draw(start, end);
    }
    
    for (Ladder ladder : ladders){
      PVector start = tiles[ladder.getStart()].getCoordinates();
      PVector end = tiles[ladder.getEnd()].getCoordinates();
      ladder.draw(start, end);
    }
    
    stroke(0, 0, 0); // reset stroke to black (Changed by ladder and snake rendering)
    
    for (Player player : players){
      player.getAnimator().animate();
    }
    
  }
  
  /**
   * If known, will return the game winner
   **/
  public Player getWinner() { return winner; }

}
