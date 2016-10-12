public class ReplayScreenVisualization extends ScreenVisualization {
  public ReplayScreenVisualization(int _width, int _height, int position_x, int position_y) {
    super(_width, _height, position_x, position_y);
  }
  
  public ReplayScreenVisualization() {
    super();
  }
  
  public void draw(Frame f) {
    displayBackground(f);
    displayMainText(f);
    displayBall(f);  
  }
}