public interface PaperController {
  public Calibration waitForColor();
  public Frame waitForFrame();
  public String getStatus();
  public void changeState();
}