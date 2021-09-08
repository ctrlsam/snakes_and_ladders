class Animator {

  private Player sprite;
  private ArrayList<PVector[]> moves;
  private ArrayList<PVector> interpolations;
  private PVector lastCoords;
  private boolean animating;
  
  
  public Animator(Player sprite){
    this.sprite = sprite;
    this.moves = new ArrayList();
    interpolations = new ArrayList();
    lastCoords = new PVector(0, 0);
    animating = false;
  }
  
  /**
   * Adds a new move to be animated
   **/
  public void addMove(PVector a, PVector b){
    moves.add(new PVector[] {a, b});
  }
  
  /**
   * Creates new interpolations if not made already, from the added moves.
   * Will go through each interpolation until exhausted
   * Will then continue to render the last updated position
   **/
  public void animate(){
    
    // first animate call //<>//
    if (interpolations.isEmpty() && !moves.isEmpty()){
      animating = true;
      for (PVector[] move : moves){
        interpolations.addAll(interpolate(move));
      }
    }
    
    // animations
    if (!interpolations.isEmpty()){
      PVector coords = interpolations.remove(0);
      sprite.draw((int) coords.x, (int) coords.y);
      handleRemove(coords);
    }
    
    // draw still
    else {
      animating = false;
      sprite.draw((int) lastCoords.x, (int) lastCoords.y);
    }
    
  }
   //<>//
  /**
   * Will ensure that moves are removed when all interpolations
   * are exhausted. Also saves last coordinates for next draw
   **/
  private void handleRemove(PVector removed){
    for (PVector[] move : moves){
      PVector target = move[1];
      if (removed == target) moves.remove(0);
    }
    
    if (interpolations.isEmpty()){
         lastCoords = removed;
         moves.clear();
    }
  }
  
  /**
   * Saves single pixel changes on x and y into a list,
   * until target coordinates are met
   **/
  private ArrayList<PVector> interpolate(PVector[] move){
    ArrayList<PVector> interpolations = new ArrayList();
    PVector current = move[0];
    PVector target = move[1];
    
    while ((current.x != target.x) || (current.y != target.y)){
      if (current.x < target.x) current.x++;
      else if (current.x > target.x) current.x--;
      
      if (current.y < target.y) current.y++;
      else if (current.y > target.y) current.y--;
      
      current = new PVector(current.x, current.y);
      interpolations.add(current);
    }
    
    return interpolations;
  }
  
  /**
   * Returns true if there are still interpolations being rendered,
   * otherwise false
   **/
  public boolean isAnimating() { return animating; }
  
}
