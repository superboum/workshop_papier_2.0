public class LampVisualization implements Visualization {
  private LED led;
  
  public LampVisualization(LED led) {
    this.led = led;
  }
  
  public void draw(Frame f) {
    if (controller.getSequenceManager().getStatus() instanceof SequenceInProgress) {
      int red_lamp = min(255, int(pow(f.getDetectedPixelCount(), 2) * 250) + min(255, int(pow(f.getEvolutionPixelCount(), 2) * 1000)));
      int green_lamp = min(30, int(pow(f.getEvolutionPixelCount(), 2) * 1000));
      int blue_lamp = 0;
    }
    
    led.setColor(red_lamp, green_lamp, blue_lamp);
  }
  
  public void draw(Calibration c) {
  }
  
  public void keyPressed() {
  }
}
