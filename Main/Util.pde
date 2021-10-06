static class Util {

  /**
   * Return tile number from row, col
   **/
  public static int getTileNumber(int row, int col){
    if (row%2 == 0 && row != 0) col = (-col + 1);
    return (10*row) + col;
  }
  
  /**
   * Java math implementation of random
   * for use in a static context
   **/
  public static int random(int min, int max) {
    int value = (int) ((Math.random() * (max - min)) + min);
    return value;
  }
  
  /**
   * Return a change in axis (positive or negative) within allowed limit
   **/
  public static int getAxisChange(int start, int limit){
    int min = -start;
    int max = Math.min(10 - start, limit);
    int change = start + (int) random(min, max);
    if (start - change == 0) return getAxisChange(start, limit);
    return change;
  }
  
  /**
   * Returns a random start and end pos inside
   * of a PVector Object
   * x = start
   * y = end
  **/
  public static PVector randomCoordinate(){
    int startCol = (int) random(0, 10);
    int startRow = (int) random(0, 10);
    
    int endCol = Util.getAxisChange(startCol, 4);
    int endRow = Util.getAxisChange(startRow, 6);
    
    PVector pos = new PVector();
    pos.x = Util.getTileNumber(startRow, startCol); 
    pos.y = Util.getTileNumber(endRow, endCol);
    
    // run again - we can't have a snake on square 100
    if (pos.x == 100 || pos.y == 100) return randomCoordinate();
    
    return pos;
  }
  
  /**
   * Check if coordinate referenced in a list of other coords (both x, y comparison
   **/
  public static boolean coordinateExists(PVector newCoord, ArrayList<PVector> coords){
    for (PVector coord : coords){
      if (newCoord.x == coord.x ||
          newCoord.y == coord.y ||
          newCoord.x == coord.y ||
          newCoord.y == coord.x){
            return true;
          }
    }
    return false;
  }
  
  /**
   * Create a list of unique spawn locations - no tile should be used twice for
   * a start or end tile
   **/
  public static ArrayList<PVector> createSpawns(ArrayList<PVector> existing, int amount){
    ArrayList<PVector> locations = new ArrayList(existing);
    for (int i = 0; i < amount; i++){
      while (true) {
        PVector newPos = randomCoordinate();
        if (coordinateExists(newPos, locations)) continue;
        locations.add(newPos);
        break;
      }
    }
    locations.removeAll(existing);
    return locations;
  }

}
