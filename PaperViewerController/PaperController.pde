public interface PaperController {
  public Calibration waitForColor();
  public Frame waitForFrame();
  public ControllerStatus getStatus();
  public void changeState();
  public SequenceManager getSequenceManager();
}

public interface ControllerStatus {
}

public static class CalibrationStatus implements ControllerStatus {
  private static CalibrationStatus INSTANCE;
  private CalibrationStatus() {}
  
  public static CalibrationStatus getInstance() {
    if(CalibrationStatus.INSTANCE == null) { CalibrationStatus.INSTANCE = new CalibrationStatus(); }
    return CalibrationStatus.INSTANCE;
  }
}

public static class CaptureStatus implements ControllerStatus {
  private static CaptureStatus INSTANCE;
  private CaptureStatus() {}
  
  public static CaptureStatus getInstance() {
    if(CaptureStatus.INSTANCE == null) { CaptureStatus.INSTANCE = new CaptureStatus(); }
    return CaptureStatus.INSTANCE;
  }
}