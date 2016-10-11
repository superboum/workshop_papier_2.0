public class ScreenVisualization implements Visualization {
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

  public void draw(Frame f) {
    displayBackground(f);
    displayText(f);
    displayBall(f);
  }
   
  public void keyPressed() {
      controller.changeState();
  }
  
  /** PRIVATE **/
  
  private void displayBackground(Frame f) {
    if (abs(f.getEvolutionPixelCount()) > 0.08f) setBackground(40,0,0);
    else setBackground(255, 209, 209);
  }
  
  private void setBackground(int red, int green, int blue) {
    fill(red, green, blue);    
    rect(position_x, position_y, vis_width, vis_height);
    noStroke();  
  }
  
  private void displayText(Frame f) {
    textSize(32 * vis_height / 1080);
    fill(130,30,0);
    textFont(font, 80 * vis_height / 1080);
    textAlign(CENTER, CENTER);
    text("NE NOUS FROISSONS PAS", vis_width/2+position_x, vis_height/2+position_y);
  }
  
  private void displayBall(Frame f) {
    int red_ball = max(130, min(255, int(f.getDetectedPixelCount() * 1000)));
    int green_ball = min(30, int(f.getEvolutionPixelCount() * 2000)) + min(60, int(f.getDetectedPixelCount() * 1000));
    int blue_ball = min(0, int(f.getEvolutionPixelCount() * 500));
  
    float size = min(vis_height, int(f.getDetectedPixelCount() * vis_height * 1.2));
  
    fill(red_ball, green_ball, blue_ball);    
    ellipse(vis_width/2+position_x, vis_height/2+position_y, size, size);
    noStroke();    
  }
}