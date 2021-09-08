class Snake extends Path{

  public Snake(int start, int end) {
      super(start, end);
  }
  
  public void draw(PVector a, PVector b){
    stroke(255, 0, 0);
    line(a.x, a.y, b.x, b.y);
  }

}
