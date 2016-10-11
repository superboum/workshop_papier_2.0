public interface PaperController {
  public Calibration waitForColor();
  public Frame waitForFrame();
  public ControllerStatus getStatus();
  public void changeState();
  public SequenceManager getSequenceManager();
}

public interface ControllerStatus {
}

public class CalibrationStatus implements ControllerStatus {
}

public class CaptureStatus implements ControllerStatus {
}