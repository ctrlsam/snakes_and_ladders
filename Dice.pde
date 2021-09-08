static class Dice {
  
  /**
   * Roll dice, returning number between 1 and 6
   **/
  public static int roll(){
    return 1 + (int)(Math.random() * (6 - 1) );
  }
}
