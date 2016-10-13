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
      led.setColor(red_lamp, green_lamp, blue_lamp);
    } else if (controller.getSequenceManager().getStatus() instanceof SequenceThanks) {
      led.setColor(255, 255, 255);
    } else {
      led.setColor(0, 0, 0);
    }
    
  }
  
  public void draw(Calibration c) {
      led.setColor(c.red, c.green, c.blue);
  }
  
  public void keyPressed() {
  }
}
