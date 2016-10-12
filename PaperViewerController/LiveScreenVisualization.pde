public class LiveScreenVisualization extends ScreenVisualization {
  public LiveScreenVisualization(int _width, int _height, int position_x, int position_y) {
    super(_width, _height, position_x, position_y);
  }
  
  public LiveScreenVisualization() {
    super();
  }
  
  public void draw(Frame f) {
    if (controller.getSequenceManager().getStatus() instanceof SequenceInProgress) {
      displayBackground(f);
      displayMainText(f);
      displayBall(f);  
    } else if (controller.getSequenceManager().getStatus() instanceof SequenceWait) {
      setBackground(130,30,0);
      displayExplanationText(f);
    } else {
      setBackground(130,30,0);
      displayGreetingText(f);
    }
  }
}