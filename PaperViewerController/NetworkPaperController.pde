import processing.net.*; 

public class NetworkPaperController implements PaperController {
  private Client connection;
  private ControllerStatus status = new CalibrationStatus();
  private SequenceManager sequenceManager = null;
  
  public NetworkPaperController(PApplet processing, String ip, int port) {
    connection = new Client(processing, ip, port);
  }
  
  private String getLine() {
    String read = connection.readStringUntil('\n');
    if (read == null) return null;
    if (split(read, ' ')[0].contains("ETA")) {
      status = CalibrationStatus.getInstance();
      return read;
    }
    if (split(read, ' ')[0].contains("CAP")) {
      status = CaptureStatus.getInstance();
      return read;
    }
    return null;
  }
  
  public void saveSequence(int n) {
    sequenceManager = new SequenceManager(n);
  }
  
  public Calibration waitForColor() {
    String read = getLine();
    if (!(status instanceof CalibrationStatus)) return null;
    return read == null ? null : new Calibration(read);
  }  
  
  public Frame waitForFrame() {
    String read = getLine();
    if (read != null && status instanceof CaptureStatus) { 
      Frame lastFrame = new Frame(read);
      if (sequenceManager != null) sequenceManager.notifyFrame(lastFrame);
      return lastFrame;
    }
    return null;
  }
  
  public SequenceManager getSequenceManager() {
    return sequenceManager;
  }
  
  public void changeState() {
    connection.write("OK\n");
  }
  
  public ControllerStatus getStatus() {
    return status;
  }
}  