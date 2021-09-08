class Ladder extends Path{

  public Ladder(int start, int end) {
      super(start, end);
  }
  
  public void draw(PVector a, PVector b){
    stroke(0, 255, 0); // Green
    line(a.x, a.y, b.x, b.y);
  }

}
