public interface Screen {
  public void draw();
}

public abstract class AbstractScreen implements Screen {
  protected ArrayList<Visualization> vis;
  
  public AbstractScreen() {
    vis = new ArrayList();
  }
  
  void calibrate() {
    Calibration c = controller.waitForColor();
    if (c != null) {
      for(Visualization v : vis) v.draw(c);
    }
  }

  void capture() {
    Frame f = controller.waitForFrame();
    if (f != null) {
      for(Visualization v : vis) v.draw(f);
    }
  }
  
  public void draw() {
    if (controller.getStatus() instanceof CalibrationStatus) calibrate();
    else if (controller.getStatus() instanceof CaptureStatus) capture();
  }
}