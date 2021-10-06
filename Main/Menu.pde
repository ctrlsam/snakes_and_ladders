public class Menu {

  private boolean isOpen;
  private PImage logo;
  private ArrayList<Button> buttons;
  private String outcome;
  
  public Menu(){
    isOpen = true;
    logo = loadImage("assets/logo.png");
    
    buttons = new ArrayList();
    buttons.add(new Button("Normal Map", 50, 400, color(45, 154, 238)));
    buttons.add(new Button("Random Map", 250, 400, color(231, 52, 72)));
    buttons.add(new Button("Quit", 450, 400, color(246, 169, 0)));
    buttons.add(new Button("Help", 600, 650, 80, 45, false, color(231, 52, 72)));
  }
  
  /**
   * Check if button is being clicked.
   * If so, will return true, else false.
   **/
  public boolean handleClick(){
    for (Button button : buttons){
      if (button.isHovering()){
        outcome = button.getText();
        if (button.shouldToggle()) toggle();
        return true;
      }
    }
    return false;
  }
  
  /**
   * Draw the menu, including logo and buttons
   **/
  public void draw(){
    background(139, 190, 118);
    image(logo, 10, 100);
    for (Button button : buttons) button.draw();
  }
  
  /**
   * Return true if menu is active (open)
   **/
  public boolean isActive() { return isOpen; }
  
  /**
   * Toggle the state of the menu
   **/
  public void toggle(){ isOpen = !isOpen; }
  
  /**
   * Get menu outcome (button press) if exists
   **/
  public String getOutcome(){ return outcome; }

}

public class Button {

  private int w = 170;
  private int h = 55;
  
  private String text;
  private int x, y;
  private color bgColor;
  private boolean toggleOnClick;
  
  
  public Button(String text, int x, int y, color bgColor){
    this.text = text;
    this.x = x;
    this.y = y;
    this.bgColor = bgColor;
    toggleOnClick = true;
  }
  
  public Button(String text, int x, int y, int w, int h, boolean toggleOnClick, color bgColor){
    this(text, x, y, bgColor);
    this.w = w;
    this.h = h;
    this.toggleOnClick = toggleOnClick;
  }
  
  /**
   * Draw button with hover styling
   **/
  public void draw(){
    strokeWeight(4);
    stroke(0); // black
    
    if (!isHovering()) fill(bgColor); // white
    else {
      cursor(HAND);
      fill(bgColor-100); // gray
    }
    rect(x, y, w, h);
    fill(255);
    textSize(20);
    text(text, x+(w/6), y+30);
  }
  
  /**
   * Check if the mouse is currently hovering over button
   **/
  private boolean isHovering(){
    return (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h);
  }
  
  /**
   * Returns if the button should toggle the menu on click
   **/
  public boolean shouldToggle() { return toggleOnClick; } 
  
  /**
   * Return the button's text
   **/
  public String getText(){ return text; }
  
}
