class Path {

  private int start;
  private int end;
  
  /**
   * Base class for Ladder and Snake
   **/
  public Path(int start, int end){
    this.start = start;
    this.end = end;
  }
  
  public int getStart() { return start; }
  public int getEnd() { return end; }
  
}
