class Ladder extends Path {
  
  private final float ladderWidth = 40;
  private final float distanceBetweenSteps = 30;

  public Ladder(int start, int end) {
      super(start, end);
  }
  
  public Ladder(PVector pos) {
      this(
        (int) Math.min(pos.x, pos.y),
        (int) Math.max(pos.x, pos.y)
      );
  }
  
  /**
   * Draw left and right side of ladder
   **/
  private void drawLadderSides(PVector a, PVector b, float offsetX, float offsetY){
    line(a.x + offsetX,
         a.y + offsetY,
         b.x + offsetX,
         b.y + offsetY);
         
    line(a.x - offsetX,
         a.y - offsetY,
         b.x - offsetX,
         b.y - offsetY);
  }
  
  /**
   * Draw steps (rungs) on ladder
   **/
  private void drawSteps(PVector b, float distance, float dirX, float dirY, float offsetX, float offsetY){
    int numSteps = (int)(distance / distanceBetweenSteps);
    for (int i = 0; i < numSteps; i++){
        float stepOffsetX = (i+1) * distanceBetweenSteps;
        float stepOffsetY = (i+1) * distanceBetweenSteps;
        
        line(
            b.x + stepOffsetX * dirX - offsetX,
            b.y + stepOffsetY * dirY - offsetY,
            b.x + stepOffsetX * dirX + offsetX,
            b.y + stepOffsetY * dirY + offsetY);
    }
  }
  
  /**
   * Draw ladder from one coordinate to another
   **/
  public void draw(PVector a, PVector b){
    float dx = a.x - b.x;
    float dy = a.y - b.y;
    float distance = dist(a.x, a.y, b.x, b.y);
    
    float dirX = dx / distance;
    float dirY = dy / distance;

    float offsetX = dirY * ladderWidth * 0.5;
    float offsetY = -dirX * ladderWidth * 0.5;

    // Draw outline
    strokeWeight(6);
    stroke(0, 0, 0); // Black
    drawLadderSides(a, b, offsetX, offsetY); 

    // Draw inner
    strokeWeight(4);
    stroke(150, 75, 0); // Brown
    drawLadderSides(a, b, offsetX, offsetY); 
          
    drawSteps(b, distance, dirX, dirY, offsetX, offsetY);
    
    // reset
    strokeWeight(2);
    stroke(0, 0, 0); // Black
    
  }

}
