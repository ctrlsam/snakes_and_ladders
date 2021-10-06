final int LADDER_AMOUNT = 5; // for random generation
final int SNAKE_AMOUNT = 5;

Board board;
Snake[] snakes;
Ladder[] ladders;
Menu menu;
Message message;

ArrayList<Player> players;
ArrayList<PVector> spawns;
boolean gameWon;

int currentPlayer;


/**
* Initialise Game
**/
void setup(){
  surface.setTitle("Snakes and Ladders");
  size(700, 700);
  frameRate(120);
  menu = new Menu();
}

/**
 * Reset the game with new random spawns
 **/
void reset(boolean randomMap){
  
  gameWon = false;
  
  if (randomMap) randomMap();
  else {
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
  }

  
  players = new ArrayList();
  
  // add 2 players
  players.add(new Player(color(255, 0, 0)));
  players.add(new Player(color(0, 0, 255)));
  
  board = new Board(players, snakes, ladders);
  
  // randomly select starting player
  currentPlayer = (int) random(0, 1);
  message = new Message("Player " + (currentPlayer + 1) + " rolls first!", 200);
}

/**
 * Using helper methods, generate random coordinates for
 * snake and ladder spawns
 **/
void randomMap(){
  spawns = Util.createSpawns(new ArrayList(), SNAKE_AMOUNT);
  
  snakes = new Snake[SNAKE_AMOUNT];
  for (int i = 0; i < SNAKE_AMOUNT; i++){
     snakes[i] = new Snake(spawns.get(i));
  }
  
  spawns = Util.createSpawns(spawns, LADDER_AMOUNT);
  
  ladders = new Ladder[LADDER_AMOUNT];
  for (int i = 0; i < LADDER_AMOUNT; i++){
     ladders[i] = new Ladder(spawns.get(i));
  }
}

/**
* Key press listener
* If enter is pressed, move player
* Also check for winner
**/
void keyPressed(){
  if (!gameWon){
    if (key == ENTER){
      if (menu.isActive()) return;
      playTurn(players.get(currentPlayer));
      currentPlayer = (currentPlayer == 0) ? 1 : 0;
      gameWon = (board.getWinner() != null);
    }
      
  }
  if (key == ESC){
    key = 0;
    message = null;
    if (board != null) menu.toggle();
  }
  
}

/**
 * Mouse action listener
 * Handles button press actions on main menu
 **/
void mousePressed(){
  // menu is not active
  if (!menu.isActive()) return;
  
  // user didnt click a button
  if (!menu.handleClick()) return;
  
  switch (menu.getOutcome()){
    
    case "Random Map":
      reset(true);
      break;
      
    case "Normal Map":
      reset(false);
      break;
      
    case "Help":
      message = new Message("Press ENTER to roll", 1000);
      break;
  
    case "Quit":
      exit();
      break;
  }
}

/**
* If player is not being animated, roll dice and move
**/
void playTurn(Player player){
  if (player.getAnimator().isAnimating()) return;
  int playerNum = players.indexOf(player) + 1;
  int roll = Dice.roll();
  
  message = new Message("Player " + playerNum + " rolled a " + roll + "!", 200);
  
  board.move(player, roll);
}


/**
* Draw background and board 
*/
void draw(){
  background(255,255,255);
  
  if (menu.isActive()){
    menu.draw();
  }
  else {
    board.draw();
    if (gameWon){
      String winner = (players.get(0).getPosition().getIndex() == 100) ? "1" : "2";
      message = new Message("Player " + winner + " won! (press ESC)", 1000);
    }
  }
  
  if (message != null) message.draw();
  
}
