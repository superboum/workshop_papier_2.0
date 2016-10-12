public abstract class ScreenVisualization implements Visualization {
  private int vis_width;
  private int vis_height;
  private int position_x;
  private int position_y;
  
  public ScreenVisualization(int _width, int _height, int position_x, int position_y) {
    this.vis_width = _width;
    this.vis_height = _height;
    this.position_x = position_x;
    this.position_y = position_y;
  }
  
  public ScreenVisualization() {
    this(width, height, 0, 0);
  }
  
  public void draw(Calibration c) {
    setBackground(c.red, c.green, c.blue);
  }
   
  public void keyPressed() {
  }
  
  /** PRIVATE **/
  
  protected void displayBackground(Frame f) {
    if (abs(f.getEvolutionPixelCount()) > 0.08f) setBackground(40,0,0);
    else setBackground(f.getBackgroundColor()[0], f.getBackgroundColor()[1], f.getBackgroundColor()[2]);
  }
  
  protected void setBackground(int red, int green, int blue) {
    fill(red, green, blue);    
    rect(position_x, position_y, vis_width, vis_height);
    noStroke();  
  }
  
  protected void displayExplanationText(Frame f) {
    textSize(32 * vis_height / 1080);
    fill(255,209,209);
    textFont(font, 80 * vis_height / 1080);
    textAlign(CENTER, CENTER);
    text("MONTRE MOI TON PAPIER", vis_width/2+position_x, vis_height/2+position_y);
  }
  
  protected void displayMainText(Frame f) {
    textSize(32 * vis_height / 1080);
    fill(130,30,0);
    textFont(font, 80 * vis_height / 1080);
    textAlign(CENTER, CENTER);
    text("NE NOUS FROISSONS PAS", vis_width/2+position_x, vis_height/2+position_y);
  }

  protected void displayGreetingText(Frame f) {
    textSize(32 * vis_height / 1080);
    fill(205,209,209);
    textFont(font, 80 * vis_height / 1080);
    textAlign(CENTER, CENTER);
    text("FIN", vis_width/2+position_x, vis_height/2+position_y);
  }
  
  protected void displayBall(Frame f) {
    int red_ball = max(130, min(255, int(f.getDetectedPixelCount() * 1000)));
    int green_ball = min(30, int(f.getEvolutionPixelCount() * 2000)) + min(60, int(f.getDetectedPixelCount() * 1000));
    int blue_ball = min(0, int(f.getEvolutionPixelCount() * 500));
  
    float size = min(vis_height, int(f.getDetectedPixelCount() * vis_height * 1.2));
    
    fill(red_ball, green_ball, blue_ball);    
    ellipse(vis_width/2+position_x, vis_height/2+position_y, size, size);
    noStroke();    
  }
}