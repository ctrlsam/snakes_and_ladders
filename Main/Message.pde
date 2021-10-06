public class Message {

  private String text;
  private int existLength;
  private int delay;
  
  private int alpha = 255;
  
  public Message(String text, int delay){
    this.text = text;
    this.delay = delay;
  
    existLength = 0;
  }
  
  /**
   * Draw text and fade at end
   **/
  public void draw(){
    // button has expired, skip drawing
    if (existLength >= delay) return;
    
    // fade out at 75 percent of delay
    float progress = (float) existLength / (float) delay;
    if (progress > 0.75) alpha -= 5;
    
    // message box
    fill(255, alpha);
    rect(50, 300, 600, 80);
    
    // text
    fill(0, alpha);
    textSize(32);
    text(text, 200, 350);
    
    existLength++;
  }
  

}
