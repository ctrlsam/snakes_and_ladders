Board board;
Snake[] snakes;
Ladder[] ladders;
ArrayList<Player> players;
boolean gameWon = false;


/**
* Initialise Game
**/
void setup(){
  surface.setTitle("Snakes and Ladders");
  size(700, 700);
  frameRate(120);
  
  players = new ArrayList();
  players.add(new Player(color(200, 255, 40)));
  
  snakes = new Snake[] {
      new Snake(16, 6),
      new Snake(61, 18),
      new Snake(51, 33),
      new Snake(86, 35),
      new Snake(94, 74),
      new Snake(97, 78),
      new Snake(92, 72),
      new Snake(63, 59),
  };
  
  ladders = new Ladder[] {
      new Ladder(0, 37),
      new Ladder(3, 13),
      new Ladder(8, 30),
      new Ladder(27, 83),
      new Ladder(20, 41),
      new Ladder(50, 66),
      new Ladder(71, 90),
      new Ladder(79, 98),
  };
  
  board = new Board(players, snakes, ladders);
}

/**
* Key press listener
* If enter is pressed, move player
* Also check for winner
**/
void keyPressed(){
  if (gameWon) return;
  if (key == ENTER){
    playTurn(players.get(0));
  }
  gameWon = (board.getWinner() != null);
}

/**
* If player is not being animated, roll dice and move
**/
void playTurn(Player player){
  if (player.getAnimator().isAnimating()) return;
  int roll = Dice.roll();
  board.move(player, roll);
}

/**
* Draw background and board 
*/
void draw(){
  background(255,255,255);
  board.draw();
  if (gameWon){
    fill(100, 255, 255);
    text("YOU WON!", 400, 700);
  }
}
