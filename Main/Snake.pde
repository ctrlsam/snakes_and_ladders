class Snake extends Path{
  
  private float freq;
  private float amp;

  public Snake(int start, int end) {
      super(start, end);
      freq = 1; // wiggle frequency
      amp = 20; // wiggle amplitude
  }
  
  /**
   * Draw body following a sin wave for sqiggles
   **/
  private void drawBody(PVector a, PVector b){
    beginShape();
    float d = PVector.dist(a,b);
    for (float i = 0; i <= d; i += 1) {
      vertex(i,sin(i*TWO_PI*freq/d)*amp);
    }
    endShape();
  }
  
  /**
   * Draw little eye
   **/
  private void drawHead(PVector end){
    stroke(0, 0, 0);
    strokeWeight(1);
    fill(255, 255, 255);
    ellipse(end.x, end.y, 7, 7);
    line(end.x, end.y, end.x, end.y);
  }
  
  /**
   * Draw snake, with outline
   **/
  public void draw(PVector a, PVector b){
    noFill();
    smooth();
    pushMatrix();
    
    // Rotate to the right angle
    translate(a.x,a.y);
    float angle = atan2(b.y-a.y,b.x-a.x);
    rotate(angle);
    
    // Draw black outline (another bigger snake)
    strokeWeight(13);
    stroke(0, 0, 0); // Black
    drawBody(a, b);
    
    strokeWeight(10);
    stroke(0, 255, 0); // Green
    drawBody(a, b);
    
    popMatrix();
    drawHead(b);
  }

}
